# Homelab Monitoring & SecOps

> OPNsense-segmented network with IDS/IPS, DNS egress control, monitoring, self-healing automations, and a mini honeypot—built on Proxmox + Portainer.

[![Status Page](https://img.shields.io/badge/Uptime-Status%20Page-informational)](#) 
[![n8n](https://img.shields.io/badge/Automation-n8n-blue)](#)
[![OPNsense](https://img.shields.io/badge/Firewall-OPNsense-orange)](#)
[![Suricata](https://img.shields.io/badge/IDS%2FIPS-Suricata-red)](#)
[![License](https://img.shields.io/badge/License-MIT-lightgrey)](LICENSE)

## Architecture
```mermaid
flowchart LR
    Internet((WAN)) -->|"NAT/Firewall"| OPN[OPNsense: VLANs and Suricata]
    OPN -->|"DNS DoH"| ADG[AdGuard Home]
    OPN -->|"Reverse Proxy"| Caddy[Caddy Server]
    Caddy --> HA[Home Assistant]
    Caddy --> Kuma[Uptime Kuma]
    Kuma --> n8n[n8n Automations]
    OPN -->|"Tailscale"| Tail[Tailscale Subnet Router]
    OPN --> Canary[OpenCanary Honeypot]

Homelab Monitoring & Automation Project

This project is part of my personal homelab, where I’m building real-world systems administration and automation experience. The goal is to monitor my self-hosted services, automate routine tasks, and practice the same workflows used in production environments.

So far, I’ve implemented a fully working monitoring → automation → alerting pipeline using:

Uptime Kuma (service monitoring)

n8n (workflow automation)

Discord Webhooks (incident notifications)

Ubuntu Server + Docker (service hosting)

This system sends me alerts when any monitored service goes down or comes back online. It includes custom parsing logic for Kuma’s webhook format and formats everything into clean, readable notifications.

🔧 Project Architecture

Uptime Kuma  →  n8n Webhook  →  Function Node  →  Discord Webhook

Uptime Kuma watches critical services (Proxmox, my services VM, HomeAssistant, etc.).

When anything changes state, Kuma calls a webhook on my n8n VM.

n8n receives the alert, normalizes the JSON payload, and builds a readable message.

A Discord webhook sends the alert to a dedicated channel.


🧠 Why I Built This

I want to build real sysadmin experience beyond desktop support:

handling webhooks

automating responses

transforming JSON

managing Dockerized services

writing backup jobs

hardening Linux servers

This project shows that I can build, host, secure, and maintain real infrastructure — and troubleshoot integrations when things don’t go perfectly.


📬 Example Alerts

Here’s the type of message that gets pushed to my Discord:

🔔 Uptime Alert
Monitor: Proxmox
Status: DOWN
URL: https://192.168.xx.xx:8006
Message: Connection timed out
Time (UTC): 2025-11-19T04:11:15.800Z


🧩 n8n Workflow Details
Webhook → Function Node → Discord
Function Node (parses Kuma’s JSON format)

const root = $json;
const body = root.body || {};
const monitor = body.monitor || {};
const heartbeat = body.heartbeat || {};

const monitorName =
  monitor.name ||
  monitor.friendly_name ||
  body.monitorName ||
  'Test Notification';

let rawStatus =
  heartbeat.status ??
  body.status ??
  'info';

let statusText = String(rawStatus).toLowerCase();
if (statusText === '0') statusText = 'down';
if (statusText === '1') statusText = 'up';
if (statusText === '2') statusText = 'pending';
if (statusText === '3') statusText = 'paused';

const msg =
  body.msg ||
  heartbeat.msg ||
  '';

const url =
  monitor.url ||
  monitor.hostname ||
  body.monitorUrl ||
  '';

const time = new Date().toISOString();

return [{
  monitorName,
  status: statusText,
  msg,
  url,
  time,
  content: [
    '🔔 Uptime Alert',
    `Monitor: ${monitorName}`,
    `Status: ${statusText.toUpperCase()}`,
    url ? `URL: ${url}` : '',
    msg ? `Message: ${msg}` : '',
    `Time (UTC): ${time}`,
  ].filter(Boolean).join('\n')
}];

Files to include:

/automation/n8n/kuma_to_discord.json
(exported n8n workflow)
/screens/kuma_alert_example.png
/screens/n8n_workflow.png


🔐 Hardening & Maintenance

As part of treating this like a real production box, I also implemented:

✓ SSH Hardening

– Disabled password authentication
– Disabled root login
– Enabled fail2ban

✓ Auto Security Updates
sudo apt install unattended-upgrades


✓ Automated Backups for Kuma & n8n

Nightly cron job:
0 3 * * * /usr/bin/rsync -a /srv/kuma /backups/kuma && /usr/bin/rsync -a /srv/n8n /backups/n8n
