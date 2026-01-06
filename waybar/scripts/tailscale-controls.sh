#!/usr/bin/env bash

# Toggle mode
if [ "$1" = "toggle" ]; then
    if tailscale status --json >/dev/null 2>&1; then
        state=$(tailscale status --json | jq -r '.BackendState')
        if [ "$state" = "Running" ]; then
            tailscale down
        else
            tailscale up
        fi
    else
        tailscale up
    fi
    exit 0
fi

# Display the status
status=$(tailscale status --json 2>/dev/null)
if [ $? -ne 0 ]; then
    echo '{"text": "", "tooltip": "Tailscale not running", "class": "disconnected"}'
    exit 0
fi

state=$(echo "$status" | jq -r '.BackendState')
ip=$(echo "$status" | jq -r '.TailscaleIPs[0]')
if [ "$state" = "Running" ]; then
    echo "{\"text\": \"\", \"tooltip\": \"Tailscale connected ($ip)\", \"class\": \"connected\"}"
else
    echo "{\"text\": \"\", \"tooltip\": \"Tailscale not running ($state)\", \"class\": \"disconnected\"}"
fi

