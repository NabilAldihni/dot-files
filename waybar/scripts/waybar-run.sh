#!/bin/sh
# Waybar 0.15 aborts (SIGABRT) if a monitor or USB-C power supply disappears
# while the battery module is scanning /sys. Restart it instead of leaving the bar gone.
trap 'exit 0' TERM INT

while true; do
    runtime="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
    display="${WAYLAND_DISPLAY:-wayland-1}"
    if [ ! -S "$runtime/$display" ]; then
        exit 0
    fi

    waybar &
    pid=$!
    wait "$pid"
    status=$?

    # Clean exit, or an intentional stop from the reload bind.
    if [ "$status" -eq 0 ] || [ "$status" -eq 130 ] || [ "$status" -eq 143 ]; then
        exit 0
    fi
    sleep 0.4
done
