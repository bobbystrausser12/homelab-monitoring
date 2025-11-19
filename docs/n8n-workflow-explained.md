n8n Workflow Explained

The n8n workflow receives the webhook from Kuma, processes it, and sends a formatted alert to Discord. The workflow has three main steps:

Webhook Node
Receives the incoming JSON payload from Uptime Kuma.

Function Node
Parses the JSON, extracts the monitor name, status, URL, and message, and creates a clean, human-readable alert string.

HTTP Request Node
Sends the final alert message to a Discord webhook URL so I can receive notifications on my phone/desktop.

Even though the logic is simple, this workflow taught me how to work with webhook integrations, how to clean and transform JSON, and how to automate notifications — all essential sysadmin tasks.
