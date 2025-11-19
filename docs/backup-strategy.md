Backup Strategy

My monitoring and automation services store their data in local Docker volumes, so I created a simple nightly backup job using rsync and cron. It copies the data directories for Uptime Kuma and n8n into a /backups folder every night at 3 AM.

The goal isn’t full enterprise backup — it’s to show I understand how to protect service state and restore quickly if something breaks. Later, I may extend this with compression, rotation, or off-device backups, but this is a solid starting point for homelab resiliency.
