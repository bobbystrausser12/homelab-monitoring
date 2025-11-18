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

# Sysadmin Homelab

This repository documents my homelab, which I use to practice system administration, automation, and monitoring.

## Phase 1 – Core Infrastructure

**Goal:** Build a small, production-style environment with:

- Proxmox hypervisor
- A dedicated "Services VM" (Ubuntu Server)
- Docker + Portainer
- Uptime Kuma for monitoring critical systems

### Current Components

- Proxmox VE host (64 GB RAM, NAS storage)
- `svcs-01` – Ubuntu Server 22.04
  - Docker + Portainer
  - Uptime Kuma (port 3001)

### Repo Layout

- `docs/` – Setup and design documentation
- `docker/` – Docker compose and deployment scripts
- `screens/` – Screenshots of the setup in action

### Next Steps (Phase 2+)

- Add AdGuard for DNS filtering and security
- Add n8n for automation + AI-assisted reports
- Add Caddy for reverse proxy and SSL
- Harden SSH and add backups + logging
