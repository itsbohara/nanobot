#!/bin/bash
# Safe gateway launcher - prevents duplicates

PIDFILE="/tmp/nanobot-gateway.pid"
LOGFILE="gateway.log"

# Check if already running
if [ -f "$PIDFILE" ]; then
    OLD_PID=$(cat "$PIDFILE")
    if ps -p "$OLD_PID" > /dev/null 2>&1; then
        echo "Gateway already running (PID: $OLD_PID)"
        echo "Logs: tail -f $LOGFILE"
        exit 1
    else
        rm "$PIDFILE"
    fi
fi

echo "Starting nanobot gateway..."
nohup nanobot gateway > "$LOGFILE" 2>&1 &
NEW_PID=$!
echo $NEW_PID > "$PIDFILE"
echo "Gateway started (PID: $NEW_PID)"
echo "Logs: tail -f $LOGFILE"
echo "Stop with: kill $NEW_PID"
