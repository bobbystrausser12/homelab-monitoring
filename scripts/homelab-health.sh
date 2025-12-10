#!/usr/bin/env bash
# Simple health check script used by n8n for the daily report.

echo "Homelab Daily Health Report"
echo "==========================="
echo

echo "Host: $(hostname)"
echo "Date: $(date -Iseconds)"
echo

echo "System Uptime:"
uptime
echo

echo "Disk Usage (/):"
df -h /
echo

echo "Memory Usage:"
free -h
echo

echo "Docker Containers Running:"
docker ps --format '{{.Names}}' | wc -l
echo

echo "Top 5 Docker Containers:"
docker ps --format '{{.Names}}\t{{.Status}}' | head -n 5
echo
