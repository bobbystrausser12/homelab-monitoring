# 🔒 Homelab Monitoring, Automation & Zero-Trust Networking

A production-style homelab featuring global DNS filtering, zero-trust access, monitoring, SecOps alerting, self-healing automations, VLAN-ready segmentation, and full internal HTTPS—built on Proxmox, TailScale, AdGuard Home, and Docker.

[![Status Page](https://img.shields.io/badge/Uptime-Status%20Page-informational)](#) 
[![n8n](https://img.shields.io/badge/Automation-n8n-blue)](#)
[![OPNsense](https://img.shields.io/badge/Firewall-OPNsense-orange)](#)
[![Suricata](https://img.shields.io/badge/IDS%2FIPS-Suricata-red)](#)
[![License](https://img.shields.io/badge/License-MIT-lightgrey)](LICENSE)

## 🚀 Project Overview

This repository documents my end-to-end homelab infrastructure, where I practice:

Linux systems administration

Network design & segmentation

DNS architecture & HTTPS

Zero-trust VPN access

Monitoring & alerting

Automation & scripting

SecOps & intrusion detection

Everything is deployed on Proxmox with Ubuntu/Debian-based VMs and Docker containers orchestrated via Portainer. My goal is to treat this homelab like a mini production environment, with real alerting pipelines, fault tolerance, and security controls.

## 🧰 Tech Stack
Infrastructure

Proxmox (virtualization)

Ubuntu Server / Debian

Docker + Docker Compose

Portainer

Networking & Security

TailScale (mesh VPN, MagicDNS, subnet routing)

AdGuard Home (DNS filtering, rewrites, DoH)

Caddy (reverse proxy + internal PKI)

OPNsense (firewall, IDS/IPS, DNS egress rules)

Suricata (network intrusion detection)

Monitoring & Automation

Uptime Kuma (availability monitoring)

n8n (automation/orchestration)

Cron + SSH Automation Scripts

Integrations

Discord Webhooks (alerting + daily reports)

RSS Feeds (tech news ingestion)

GeoIP enrichment

## 🏗️ Architecture Overview

flowchart LR
    subgraph ClientDevices["Remote Clients"]
        L1["Laptop (TailScale)"]
        P1["Phone (TailScale)"]
    end

    subgraph TailScale["TailScale Mesh Network"]
        TS["MagicDNS + Zero-Trust Routing"]
    end

    subgraph DC["Proxmox Homelab"]
        AG["AdGuard Home<br>DNS + Ad Blocking"]
        RP["Caddy Reverse Proxy<br>Local HTTPS + PKI"]
        N8N["n8n Automations"]
        KUMA["Uptime Kuma"]
        PORT["Portainer"]
        HA["Home Assistant"]
    end

    L1 --> TS --> AG
    P1 --> TS --> AG

    AG --> RP
    RP --> N8N
    RP --> KUMA
    RP --> PORT
    RP --> HA

## 🌐 Global DNS, Zero-Trust Access & Internal HTTPS (NEW)

I deployed a secure global DNS and HTTPS infrastructure using TailScale, AdGuard, and Caddy. This allows me to securely access all homelab services from anywhere in the world—work, mobile hotspot, public WiFi—without exposing a single port to the internet.

## 🔐 Features

Zero-trust remote access (no port forwards, fully private network)

Global DNS filtering through AdGuard over TailScale

MagicDNS + custom .lab internal domains

https://n8n.lab

https://kuma.lab

https://portainer.lab

https://ha.lab

Caddy internal certificate authority for trusted HTTPS

DNS rewrites to internal service IPs

Subnet routing from TailScale → Proxmox → LAN

## 🧠 Technical Achievements

Configured AdGuard to bind on all interfaces (0.0.0.0) for TailScale DNS resolution

Implemented TailScale DNS override + MagicDNS to route .lab domains globally

Built a dedicated reverse proxy VM with Caddy using internal CA:

tls internal
reverse_proxy 192.168.50.X:PORT

Installed local CA trust on Linux client to eliminate HTTPS warnings

Ensured full DNS resilience even when switching networks (hotspot, work WiFi, home LAN)

This section alone demonstrates networking, VPN, DNS, PKI, and reverse proxy expertise—highly valuable for SysAdmin, DevOps, and Security roles.


## 🛠️ Functional Components
Phase 1 — Real-Time Availability Monitoring

Uptime Kuma monitors:

Proxmox host

VMs and Docker services

Internal applications

Alerts are sent to n8n via webhook for processing

n8n formats alerts and sends them to a private Discord channel

Skills demonstrated: JSON handling, webhooks, REST APIs, incident detection.

Phase 2 — Daily Homelab Ops Report + Motivation

Every morning at 6:20 AM:

n8n SSHes into the server

Runs a custom health script:

uptime

memory + disk usage

container status

Formats results into Markdown

Adds a motivational video

Sends it to Discord

Skills demonstrated: automation, scripting, remote execution, n8n workflow design.

Phase 2 — Daily Tech News Digest

At 8:05 AM:

n8n consumes an RSS feed (Ars Technica)

Parses the latest 3 articles

Formats a clean summary for Discord

Skills demonstrated: API ingestion, automation pipelines, data parsing.

Phase 3 — Security Monitoring & Intrusion Detection

Implemented a lightweight host-based intrusion detection system:

Watches /var/log/auth.log in real time

Detects:

failed SSH attempts

successful logins

invalid users

Tracks repeated failures to identify brute-force attempts

Enriches events with GeoIP data

Sends structured JSON security alerts through n8n → Discord

Skills demonstrated: log analysis, security monitoring, alerting pipelines, SecOps fundamentals.

📸 Screenshots

Located in /screens, including:

n8n workflow UIs

automation logic (function nodes)

Kuma dashboards

Discord alert examples

server metrics snapshots

## 📂 Repository Structure

docs/
  architecture-overview.md
  uptime-kuma-webhooks.md
  n8n-workflow-explained.md
  daily-report-automation.md
  morning-tech-news.md
  ssh-hardening.md
  backup-strategy.md
  troubleshooting.md

scripts/
  homelab-health.sh

automation/n8n/
  daily_report_and_motivation.json
  morning_tech_news.json

screens/
  n8n/
  kuma/
  discord/
  server/

## 🎯 Why I Built This

I’m working toward a career in:

Systems Administration

DevOps / Cloud Engineering

Security Engineering / SecOps

This homelab helps me practice:

Monitoring & alerting

Network design & VPNs

DNS & PKI

Reverse proxying

Linux hardening

Infrastructure automation

Real troubleshooting

Documentation & workflows

Everything mirrors the responsibilities of a junior–mid sysadmin or cloud engineer in production.

🚧 Upcoming: Kubernetes Migration

    Deploying a k3s High-Availability Cluster on Proxmox.

    Migrating stateless applications (Whoami, Caddy) from Docker Compose to Kubernetes Manifests/Helm Charts.

    Implementing GitOps (using ArgoCD) to automate deployments from this repo.

## 🧭 Future Enhancements

Grafana + Prometheus container resource dashboards

Weekly uptime reports generated from Kuma API

Automated backup integrity verification

Add metrics for Home Assistant

Expand TailScale / OPNsense segmentation with VLANs

## 📬 Contact

If you’d like to collaborate, suggest improvements, or chat about homelabs, feel free to open an issue or message me on LinkedIn.

## ⭐ Final Notes for Recruiters

This project demonstrates hands-on experience with:

✔ Linux system administration
✔ Networking & zero-trust architecture
✔ DNS, HTTPS, PKI, and reverse proxying
✔ Monitoring & automation pipelines
✔ Security alerting & log analysis
✔ Proxmox virtualization
✔ Dockerized service hosting
