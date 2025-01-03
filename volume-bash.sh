#!/bin/bash

# Define ADB path
ADB_PATH="/data/data/com.termux/files/usr/bin/adb"  # Replace with the correct path if necessary

# Define commands
FIRST_COMMAND=("$ADB_PATH" "shell" "settings" "put" "secure" "enabled_accessibility_services" "None")
TVQUICKPRO_COMMAND="dev.vodik7.tvquickactions/dev.vodik7.tvquickactions.KeyAccessibilityService"
DISPATCH_COMMAND="com.spauldhaliwal.dispatch/com.spauldhaliwal.dispatch.services.DispatchHomeService"
COMBINED_SERVICES="$TVQUICKPRO_COMMAND:$DISPATCH_COMMAND"
# Define regex pattern for volume up/down events
VOLUME_PATTERN="KEYCODE_VOLUME_"

# Function to get current time for filtering logs
get_current_time() {
    date "+%m-%d %H:%M:%S.%3N"
}

# Trap Ctrl+C to exit gracefully
trap 'echo "Stopping script..."; exit 0' SIGINT

while true; do
    # Clear logcat and get the current time
    "$ADB_PATH" logcat -c
    CURRENT_TIME=$(get_current_time)

    # Start logcat and process each line
    "$ADB_PATH" logcat -T "$CURRENT_TIME" | while read -r line; do
        if [[ "$line" =~ $VOLUME_PATTERN ]]; then
            #echo "Volume button pressed. Executing first command..."
            "${FIRST_COMMAND[@]}"

            echo "Waiting 10 seconds..."
            sleep 10

            echo "Executing second command..."
            "$ADB_PATH" shell settings put secure enabled_accessibility_services "$COMBINED_SERVICES"

            # Clear logcat and restart monitoring
            "$ADB_PATH" logcat -c
            CURRENT_TIME=$(get_current_time)
            continue
        fi
    done
done
