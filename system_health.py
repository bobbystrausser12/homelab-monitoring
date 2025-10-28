#!/usr/bin/env python3
import psutil, requests, json

# Collect system metrics
data = {
    "cpu_percent": psutil.cpu_percent(interval=1),
    "ram_percent": psutil.virtual_memory().percent,
    "disk_percent": psutil.disk_usage('/').percent
}

# Print to console or send to n8n webhook
print(json.dumps(data, indent=2))

# Example of sending data to your n8n webhook:
# requests.post("https://your-n8n-webhook-url", json=data)
