#!/bin/bash

# This function checks the current audio state and updates the icon
check_audio_state() {
    # Fetch sink and mute info in one call
    sinks_info=$(pactl list sinks)

    # Check if any Bluetooth sink is available
    bt_sink=$(echo "$sinks_info" | grep -E "bluez")

    if [[ -n $bt_sink ]]; then
        # Check if the Bluetooth sink is muted
        echo "%{F#147ddd}%{F}"  # Bluetooth icon (connected)
    else
        # Check if the default sink is muted
        default_sink=$(pactl info | grep "Default Sink" | awk '{print $3}')
        if echo "$sinks_info" | grep -A 15 "$default_sink" | grep -q "Mute: no"; then
            echo "%{F#c678dd}%{F}"  # Regular audio icon
        else
            echo "%{F#686868} %{F}"

        fi
        
        
    fi
    
}

# Initial state check
check_audio_state

# Listen for changes and update in real-time
# We will only react to events that affect audio sinks or streams
pactl subscribe | while read -r event; do
    if echo "$event" | grep -q -E 'sink|stream'; then
        # Check and update only on sink/stream changes (e.g., mute, unmute, switch device)
        check_audio_state
    fi
    # Sleep a tiny bit to avoid constant looping, keeping CPU usage low
    sleep 0.05
done

