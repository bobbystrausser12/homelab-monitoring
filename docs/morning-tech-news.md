# Morning Tech News Automation

This workflow posts a short tech news digest to my Discord channel every morning, right after the homelab health report.

## What it does

- Reads an RSS feed from a tech news site (currently the Ars Technica technology feed).
- Takes the first three articles from the feed.
- Formats their titles, timestamps, and URLs into a simple Markdown message.
- Sends the digest to the same Discord channel I use for homelab alerts.

## Workflow structure

1. **Cron (n8n)**  
   Triggers daily at around 8:05 AM.

2. **RSS Read Node**  
   Fetches articles from the Ars Technica technology RSS feed.

3. **Function Node**  
   - Receives all RSS items from the previous node.
   - Selects the top 3 items.
   - Builds a message like:

     ```text
     📰 Top Tech News — 2025-11-19

     Here are the latest articles from Ars Technica:

     1. **Article Title One**
        🕒 2025-11-19T13:03:00Z
        🔗 https://example.com/article1

     2. **Article Title Two**
        🕒 ...
        🔗 ...

     3. **Article Title Three**
        🕒 ...
        🔗 ...
     ```

4. **HTTP Request Node (Discord)**  
   Sends the assembled text to a Discord webhook.

This workflow is a simple way to keep up with the latest tech news using automation, and it demonstrates that I can work with RSS feeds, multiple-item inputs in n8n, and basic text formatting for chat platforms.
