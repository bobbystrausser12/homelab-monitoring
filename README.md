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
    Internet((WAN)) -->|"NAT/Firewall"| OPN[OPNsense: VLANs + Suricata]
    OPN -->|"DNS (DoH)"| ADG[AdGuard Home]
    OPN -->|"Reverse Proxy"| Caddy[Caddy]
    Caddy --> HA[Home Assistant]
    Caddy --> Kuma[Uptime Kuma]
    Kuma --> n8n[n8n Automations]
    OPN -->|"Tailscale"| Tail[Tailscale Subnet Router]
    OPN --- Canary[OpenCanary (Honeypot)]
