# Infrastructure Overview

## Proxmox Host

- Hostname: proxmox-01
- CPU: 12th Gen Intel(R) Core(TM) i3-12100F (4 cores / 8 threads)
- RAM: 64 GB
- Storage:
  - 1 TB NVMe (VM storage)
  - 2 x 1 TB SSD (ZFS mirror for NAS)
  - 2 x 4 TB HDD (ZFS mirror for NAS)
- OS: Proxmox VE 8.4.14

## Containers
- Name: Tailscale
- vCPU: 1
- RAM: 512 MiB
- Disk: 8 GB
- Purpose: Tailscale Host

## Virtual Machines

### Services VM
- Name: Ubuntu-Portainer
- OS: Ubuntu Server 22.04 LTS
- vCPU: 4
- RAM: 8 GB
- Disk: 80 GB
- Purpose: Docker/Portainer stack (monitoring, automation, etc.)

- Name: HomeAssistant
- OS: Home Assistant 16.0
- vCPU: 2
- RAM: 9.77 GiB
- Disk: 32 GB
- Purpose: Home Assistant Environment (automate lights, power delivery, AI assistant(upcoming project))

## Network (Phase 1)

- Flat LAN (no VLANs yet)
- Services VM IP: 192.168.X.Y
- Access:
  - SSH to svcs-01
  - Proxmox Web UI: https://192.168.X.P:8006

