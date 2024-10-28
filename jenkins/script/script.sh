#!/bin/bash

# Set the threshold percentage (e.g., 80%)
THRESHOLD=80

# Get the list of mounted filesystems and their usage
df -H | grep '^/' | while read line; do
    # Extract filesystem, size, used, available, use% and mount point
    FILESYSTEM=$(echo $line | awk '{print $1}')
    USE_PERCENT=$(echo $line | awk '{print $5}' | sed 's/%//')

    # Check if the usage exceeds the threshold
    if [ "$USE_PERCENT" -ge "$THRESHOLD" ]; then
        echo "Warning: Disk space on $FILESYSTEM is critically low at ${USE_PERCENT}%."
        echo "Consider cleaning up space."
        # Optionally, send an alert email (uncomment below)
        # echo "Disk space on $FILESYSTEM is critically low at ${USE_PERCENT}%." | mail -s "Disk Space Alert" your-email@example.com
    fi
done

# Optionally, you can summarize the overall disk usage
echo "Overall Disk Usage:"
df -H | grep '^/'

