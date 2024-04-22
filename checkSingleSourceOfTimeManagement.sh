#!/bin/bash

# Check if NTP package is installed
if ! command -v ntpq &> /dev/null; then
    echo "NTP package is not installed. Please install NTP first."
    exit 1
fi

# Check NTP configuration file
ntp_conf="/etc/ntp.conf"
if [ ! -f "$ntp_conf" ]; then
    echo "NTP configuration file ($ntp_conf) not found."
    exit 1
fi

# Check if NTP service is running
if ! systemctl is-active --quiet ntp; then
    echo "NTP service is not running."
    exit 1
fi

# Get NTP server information
ntp_servers=$(grep "^server" "$ntp_conf" | awk '{print $2}')

# Check if NTP servers are configured
if [ -z "$ntp_servers" ]; then
    echo "No NTP servers are configured in $ntp_conf."
    exit 1
fi

echo "NTP configuration is valid."
echo "NTP servers:"
echo "$ntp_servers"