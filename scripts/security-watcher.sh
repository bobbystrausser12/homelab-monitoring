```bash
#!/usr/bin/env bash
# security-watcher.sh
# Host-based intrusion detection for SSH on the services VM.
# Tails /var/log/auth.log, detects failed/successful logins, invalid users,
# brute-force patterns, enriches with GeoIP, and sends JSON alerts to n8n.

LOGFILE="/var/log/auth.log"
WEBHOOK_URL="http://<SERVICES_VM_IP>:5678/webhook/security-alert"  # replace with your n8n IP

# For brute-force tracking
BRUTE_LOG="/tmp/failed_login_window.log"
WINDOW=300        # seconds (5 minutes)
THRESHOLD=5       # failed attempts from same IP within WINDOW

touch "$BRUTE_LOG"

get_geo() {
    local ip="$1"
    local geo country region city isp

    # Basic GeoIP lookup (public API)
    geo=$(curl -s "http://ip-api.com/json/$ip?fields=status,country,regionName,city,isp,org,query")
    country=$(echo "$geo" | jq -r '.country // ""')
    region=$(echo "$geo" | jq -r '.regionName // ""')
    city=$(echo "$geo" | jq -r '.city // ""')
    isp=$(echo "$geo" | jq -r '.isp // ""')

    # echo as "country|region|city|isp"
    echo "$country|$region|$city|$isp"
}

tail -Fn0 "$LOGFILE" | while read -r line; do

    # FAILED LOGIN (SSH)
    if echo "$line" | grep -q "Failed password"; then
        user=$(echo "$line" | awk '{print $(NF-5)}')
        ip=$(echo "$line" | awk '{print $(NF-3)}')

        IFS='|' read -r country region city isp <<< "$(get_geo "$ip")"

        # Send individual failed_login event
        curl -s -X POST -H "Content-Type: application/json" \
        -d "{\"type\":\"failed_login\",\"user\":\"$user\",\"ip\":\"$ip\",\"country\":\"$country\",\"region\":\"$region\",\"city\":\"$city\",\"isp\":\"$isp\",\"log\":\"$line\"}" \
        "$WEBHOOK_URL"

        # Record this failure for brute-force detection
        now=$(date +%s)
        echo "$now $ip" >> "$BRUTE_LOG"

        # Keep only entries within the last WINDOW seconds
        awk -v now="$now" -v win="$WINDOW" '$1 >= now-win {print}' "$BRUTE_LOG" > "${BRUTE_LOG}.tmp" && mv "${BRUTE_LOG}.tmp" "$BRUTE_LOG"

        # Count how many recent failures this IP has
        count=$(awk -v ip="$ip" '$2 == ip {c++} END {print c+0}' "$BRUTE_LOG")

        # If above threshold, send brute-force alert (also enriched)
        if [ "$count" -ge "$THRESHOLD" ]; then
            curl -s -X POST -H "Content-Type: application/json" \
            -d "{\"type\":\"bruteforce_attempt\",\"user\":\"$user\",\"ip\":\"$ip\",\"count\":\"$count\",\"window\":\"$WINDOW\",\"country\":\"$country\",\"region\":\"$region\",\"city\":\"$city\",\"isp\":\"$isp\",\"log\":\"$line\"}" \
            "$WEBHOOK_URL"
        fi
    fi

    # SUCCESSFUL LOGIN
    if echo "$line" | grep -q "Accepted password"; then
        user=$(echo "$line" | awk '{print $(NF-5)}')
        ip=$(echo "$line" | awk '{print $(NF-3)}')

        IFS='|' read -r country region city isp <<< "$(get_geo "$ip")"

        curl -s -X POST -H "Content-Type: application/json" \
        -d "{\"type\":\"successful_login\",\"user\":\"$user\",\"ip\":\"$ip\",\"country\":\"$country\",\"region\":\"$region\",\"city\":\"$city\",\"isp\":\"$isp\",\"log\":\"$line\"}" \
        "$WEBHOOK_URL"
    fi

    # INVALID USER (Enumeration)
    if echo "$line" | grep -q "Invalid user"; then
        ip=$(echo "$line" | awk '{print $(NF)}')

        IFS='|' read -r country region city isp <<< "$(get_geo \"$ip\")"

        curl -s -X POST -H "Content-Type: application/json" \
        -d "{\"type\":\"invalid_user\",\"ip\":\"$ip\",\"country\":\"$country\",\"region\":\"$region\",\"city\":\"$city\",\"isp\":\"$isp\",\"log\":\"$line\"}" \
        "$WEBHOOK_URL"
    fi

done
