#!/usr/bin/env bash
status=$(tailscale status --json 2>/dev/null)
if [ $? -ne 0 ]; then
    echo '{"text": "", "tooltip": "Tailscale not running", "class": "disconnected"}'
    exit 0
fi

state=$(echo "$status" | jq -r '.BackendState')
if [ "$state" = "Running" ]; then
    echo "{\"text\": \"\", \"tooltip\": \"Tailscale connected ($ip)\", \"class\": \"connected\"}"
else
    echo "{\"text\": \"\", \"tooltip\": \"Tailscale backend not running ($state)\", \"class\": \"disconnected\"}"
fi

