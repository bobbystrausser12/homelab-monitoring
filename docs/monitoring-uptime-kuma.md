# Monitoring with Uptime Kuma

## Purpose

Uptime Kuma is used to monitor:
- Proxmox host availability
- Services VM availability (SSH)
- External Internet reachability

## Monitors (Phase 1)

1. **Proxmox Web UI**
   - Type: HTTP(s)
   - URL: https://<proxmox-ip>:8006
   - Interval: 60 seconds

2. **svcs-01 SSH**
   - Type: TCP Port
   - Host: <svcs-01-ip>
   - Port: 22
   - Interval: 60 seconds

3. **Cloudflare DNS**
   - Type: Ping
   - Host: 1.1.1.1
   - Interval: 60 seconds
