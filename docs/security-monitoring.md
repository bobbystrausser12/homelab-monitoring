# Security Monitoring & Intrusion Detection

This part of the project focuses on basic host-based intrusion detection for my services VM. The goal is not to replace a full SIEM, but to show that I understand how to:

- Read and interpret Linux authentication logs.
- Detect suspicious SSH behavior (failed logins, invalid users, brute-force patterns).
- Enrich security events with extra context (GeoIP).
- Send structured alerts into an automation system (n8n) and notify in real time.

## What I Monitor

I monitor SSH-related events from `/var/log/auth.log`, including:

- Failed password attempts.
- Successful logins.
- Attempts to log in as invalid or non-existent users.
- Possible brute-force attacks (many failures from the same IP over a short period).

## Security Watcher Script

On my services VM, I run a small Bash script under systemd that tails `/var/log/auth.log` and reacts to new lines in real time. For each relevant event, it:

1. Extracts the username and source IP.
2. Performs a GeoIP lookup using a public API (when the IP is public).
3. Tracks failed logins per IP in a rolling 5-minute window to detect brute-force behavior.
4. Sends a JSON payload to an n8n webhook endpoint.

This gives me a continuous security signal from the host, without needing to install heavyweight agents.

## Brute-Force Detection Logic

To approximate brute-force behavior, I track failed logins per IP:

- Time window: last 300 seconds (5 minutes).
- Threshold: 5 or more failures from the same IP in that window.

When an IP crosses the threshold, the script sends a `bruteforce_attempt` event with the IP, username, attempt count, and GeoIP metadata. This is surfaced as a high-urgency alert in Discord.

## n8n Security Alerts Workflow

In n8n, I have a dedicated workflow for security alerts:

1. **Webhook node** – receives JSON payloads from the security watcher script.
2. **Function node** – normalizes the data and builds a readable message, including:
   - event type (failed login, successful login, invalid user, brute-force)
   - user and IP
   - location (when available)
   - ISP (when available)
   - original auth.log line
   - timestamp
3. **HTTP Request node** – posts the formatted alert into a Discord channel using a webhook.

This gives me a simple but realistic “SOC-like” alerting flow for my homelab.

## systemd Integration

The security watcher script runs as a systemd service so it starts automatically and restarts if it fails. The unit file looks like this:

```ini
[Unit]
Description=Security Log Watcher (SSH intrusion detection)
After=network-online.target

[Service]
Type=simple
ExecStart=/usr/local/bin/security-watcher.sh
Restart=always
RestartSec=5
User=root

[Install]
WantedBy=multi-user.target

