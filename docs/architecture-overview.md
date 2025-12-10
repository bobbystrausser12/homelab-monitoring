Homelab Monitoring & Automation — Architecture Overview

This project combines several self-hosted services to create a simple but reliable monitoring and alerting system. The goal is to treat my homelab like a small production environment, with automation, notifications, and basic hardening.

The setup is built around three components:

Uptime Kuma monitors my Proxmox host and service VMs.

n8n receives webhooks from Kuma and formats the alert data.

Discord Webhooks deliver clean alerts to a dedicated channel.

Everything runs on an Ubuntu VM with Docker, which keeps services isolated and easy to maintain. This architecture gives me hands-on experience with webhooks, automation pipelines, JSON parsing, and containerized services — skills directly aligned with real sysadmin and SRE roles.
