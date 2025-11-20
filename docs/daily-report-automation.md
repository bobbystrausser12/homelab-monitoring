# Daily Report & Motivation Automation

This workflow sends me a daily homelab status report and a motivational video link every morning via Discord.

## What it does

- Connects to my services VM over SSH.
- Runs a small health script (`homelab-health.sh`) that prints uptime, disk usage, memory usage, and basic Docker info.
- Wraps the output in a readable message inside an n8n Function node.
- Picks a random “morning motivation” YouTube video from a short curated list.
- Sends everything to a Discord channel using a webhook.

## Workflow structure

1. **Cron (n8n)**  
   Triggers once a day at 6:30 AM.

2. **SSH Node**  
   Uses key-based SSH to run `/usr/local/bin/homelab-health.sh` on my Ubuntu services VM.

3. **Function Node**  
   - Reads the script output from the SSH node.  
   - Builds a message that looks like:

     ```text
     📅 Daily Homelab Report — 2025-11-19

     ==== System Health ====
     <uptime, disk, memory, docker info>

     ==== Daily Motivation ====
     ▶ https://youtube.com/...
     ```

4. **HTTP Request Node (Discord)**  
   Posts the final message to a Discord webhook so I see it on my phone and desktop.

This workflow shows that I can combine cron-style scheduling, SSH, shell scripting, and HTTP integrations to automate routine checks in my homelab.
