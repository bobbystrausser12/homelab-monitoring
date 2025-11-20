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
