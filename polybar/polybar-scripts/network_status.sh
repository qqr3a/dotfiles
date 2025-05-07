#!/bin/bash

# Define the interface names
WIRELESS_IFACE="wlan0"
WIRED_IFACE="enp8s0"

# Get the network statuses
WIRELESS_STATUS=$(cat /sys/class/net/$WIRELESS_IFACE/operstate 2>/dev/null)
WIRED_STATUS=$(cat /sys/class/net/$WIRED_IFACE/operstate 2>/dev/null)

# Get the wireless SSID and wired IP address
SSID=$(iwgetid -r)
WIRED_IP=$(ip -4 addr show $WIRED_IFACE | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

# Output based on status
if [ "$WIRED_STATUS" = "up" ]; then
    echo "%{F#F0C674}%{F-} $WIRED_IP"
elif [ "$WIRELESS_STATUS" = "up" ]; then
    echo "%{F#F0C674} %{F-} $SSID"
else
    echo "%{F#F0C674} %{F-} No Network"
fi
