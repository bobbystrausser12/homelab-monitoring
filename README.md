# Homelab Monitoring & SecOps

> OPNsense-segmented network with IDS/IPS, DNS egress control, monitoring, self-healing automations, and a mini honeypot—built on Proxmox + Portainer.

[![Status Page](https://img.shields.io/badge/Uptime-Status%20Page-informational)](#) 
[![n8n](https://img.shields.io/badge/Automation-n8n-blue)](#)
[![OPNsense](https://img.shields.io/badge/Firewall-OPNsense-orange)](#)
[![Suricata](https://img.shields.io/badge/IDS%2FIPS-Suricata-red)](#)
[![License](https://img.shields.io/badge/License-MIT-lightgrey)](LICENSE)

🚀 Homelab Monitoring & Automation System
A self-hosted project for real-time monitoring, daily automation, and production-style systems administration.



🌐 Overview
This project is part of my personal homelab where I practice Linux administration, automation, and monitoring using real infrastructure. The goal is to treat my homelab like a small production environment—complete with alerting, scheduled tasks, log processing, backups, and service health checks.

Everything in this repository was built by me on a Proxmox-hosted Ubuntu VM running Docker. I use this environment to learn, automate, and solve problems the same way a Systems Administrator or Cloud Engineer would in a real job.



🧰 Tech Stack
Infrastructure:
  Proxmox
  Ubuntu Server
  Docker + Docker Compose

Monitoring & Automation:
  Uptime Kuma (service monitoring)
  n8n (automation/orchestration)
  Cron + SSH scripts (health checks)

Integrations:
  Discord Webhooks (alerting & daily reports)
  RSS Feeds (tech news ingestion)

Security & Reliability:
  SSH hardening (no root login, key-based auth, fail2ban)
  Unattended security updates
  Nightly backup jobs (cron + rsync)



🛠️ What This System Does
1. Real-Time Service Monitoring (Phase 1)
  Uptime Kuma monitors my Proxmox host, service VMs, and containers.
  Alerts flow into an n8n webhook.
  A Function node normalizes Kuma’s JSON payloads.
  Alerts are formatted and posted into a private Discord channel.
This gives me real-world experience with incident detection, JSON parsing, and webhook integrations.

2. Daily Homelab Report + Motivation (Phase 2)
Every morning at 8 AM:
  n8n connects to my services VM over SSH
  Runs a custom health script that reports:
    uptime
    disk usage
    memory usage
    Docker container status
  Wraps the results into a Markdown report
  Adds a curated motivational video
  Sends the report to Discord
This simulates the daily operational checks a SysAdmin might perform before the workday starts.

3. Daily Tech News Digest (Phase 2)
At 8:05 AM:
  n8n reads a tech RSS feed (Ars Technica Technology Lab)
  Selects the latest 3 articles
  Formats them with title, timestamp, and link
  Sends a clean summary to Discord
This keeps me updated and demonstrates automation of external data ingestion.

📸 Screenshots
(Screenshots live inside the /screens folder.)
  n8n workflow overviews
  Function node logic
  Example alerts from Discord
  Kuma dashboard
  SSH hardening config
  Backup cron job
These help visualize exactly how the system works.



📂 Project Structure
docs/
  ├─ architecture-overview.md
  ├─ uptime-kuma-webhooks.md
  ├─ n8n-workflow-explained.md
  ├─ daily-report-automation.md
  ├─ morning-tech-news.md
  ├─ ssh-hardening.md
  ├─ backup-strategy.md
  └─ troubleshooting.md

scripts/
  └─ homelab-health.sh

automation/
  └─ n8n/
       ├─ daily_report_and_motivation.json
       └─ morning_tech_news.json

screens/
  ├─ n8n/
  ├─ kuma/
  ├─ discord/
  └─ server/



🎯 Why I Built This
I’m working toward a full-time Systems Administrator / Cloud Support / Security role.
This homelab lets me:
  Build real-world automation
  Practice monitoring and alerting
  Work with JSON, APIs, webhooks, and scripting
  Learn Dockerized service hosting
  Harden Linux servers
  Build documentation and workflows
  Debug issues end-to-end
Everything here mirrors the responsibilities of an entry-level SysAdmin or Cloud engineer.

💡 Future Improvements
Weekly uptime report (aggregate from Kuma’s API)
Backup verification workflow
Add Home Assistant metrics
Container resource dashboards (Grafana/Prometheus)



📬 Contact

If you have tips, want to collaborate, or have feedback, feel free to open an issue or reach out on LinkedIn.



### 4. Phase 3 – Security Monitoring & Intrusion Detection

To practice security operations in a realistic way, I added a lightweight host-based intrusion detection pipeline on my services VM.

This pipeline:

- Watches `/var/log/auth.log` in real time.
- Detects failed SSH logins, successful logins, and invalid user attempts.
- Tracks repeated failures per IP in a sliding 5-minute window to flag possible brute-force attacks.
- Enriches each event with GeoIP data (country, region, city, ISP) when available.
- Sends structured JSON alerts into n8n, which formats them and pushes human-readable security alerts to a Discord channel.

This simulates the kind of basic detection and alerting that a SOC or SysAdmin team would rely on for SSH hardening and early-stage intrusion detection.
