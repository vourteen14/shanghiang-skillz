#!/bin/bash

LOG_FILE="health_check.log"
SERVER=$1
PORT=${2:-80}
SSH_USER=${USER}
DISK=$(ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no "$SSH_USER@$SERVER" "df -h / | awk 'NR==2 {print \$5}'" 2>/dev/null)

[ -z "$SERVER" ] && { echo "Usage: $0 <server> [port]"; exit 1; }

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"; }

if ping -c 3 -W 2 "$SERVER" &>/dev/null; then
    echo "Server is reachable."
    log "Server is reachable."
else
    echo "Server unreachable."
    log "Server unreachable."
    exit 1
fi

if curl -s --max-time 5 "http://$SERVER:$PORT" &>/dev/null; then
    echo "Web service on port $PORT is UP."
    log "Web service on port $PORT is UP."
else
    echo "Web service on port $PORT is DOWN."
    log "Web service on port $PORT is DOWN."
fi

if [ -n "$DISK" ]; then
    echo "Disk usage on / is $DISK."
    log "Disk usage on / is $DISK."
else
    echo "Unable to check disk usage."
    log "Unable to check disk usage."
fi

echo "Results logged to $LOG_FILE"
