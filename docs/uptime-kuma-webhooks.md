Uptime Kuma Webhooks

Uptime Kuma sends webhook notifications whenever a monitored service goes UP or DOWN. Each webhook includes details like the monitor name, current status, message, and timestamps.

In my setup, Kuma points its webhook URL to an n8n Webhook node running on my services VM. For test notifications, the payload structure is very simple, but real alerts include more detailed monitor and heartbeat data. I built a Function node in n8n that reads Kuma’s payload, normalizes the fields, and creates a readable alert message.

Using webhooks from Kuma gave me practice with integrating monitoring systems and handling real JSON payloads — a common task in automation and operations work.
