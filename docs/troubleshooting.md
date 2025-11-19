Troubleshooting Notes

This project required a good amount of debugging. I captured the most important findings here:

Uptime Kuma’s webhook test payload is different from real alerts, so some fields like monitor and heartbeat return null.

The correct JSON structure for parsing alert data is nested under the body field (body.monitor, body.heartbeat).

When ports were already in use in Docker, I fixed the conflicts by checking container mappings with docker ps and adjusting compose configs.

If n8n didn’t receive Kuma’s webhook, the issue was usually incorrect URLs (using localhost instead of the VM’s LAN IP).

Discord errors were often caused by invalid JSON formatting — switching to n8n’s body parameters with expressions solved it.

Troubleshooting this pipeline helped me get more comfortable with logs, Docker networking, JSON structures, and webhook-based integrations.
