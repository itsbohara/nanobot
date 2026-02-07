#!/bin/bash
# Stop gateway safely

PIDFILE="/tmp/nanobot-gateway.pid"

if [ -f "$PIDFILE" ]; then
    PID=$(cat "$PIDFILE")
    if ps -p "$PID" > /dev/null 2>&1; then
        echo "Stopping gateway (PID: $PID)..."
        kill "$PID"
        rm "$PIDFILE"
        echo "Stopped."
    else
        echo "Gateway not running (stale pidfile removed)"
        rm "$PIDFILE"
    fi
else
    echo "Gateway not running"
fi
