#!/bin/bash

# This script will log processes that exceed specified thresholds, which can be particularly useful for
# catching runaway processes early.

# The following code will gather CPU and memory usage of processes that exceed predefined thresholds.
# You can schedule this to run at regular intervals using a tool like cron.

# To automate with cron:
# crontab -e
# Write this:
# * * * * * /path/to/inspectResourceUtilization.sh
# The above runs it every minute

# Script to inspect resource utilization

# LOGFILE="/var/log/resource_inspection.log"
LOGFILE="./resource_inspection.log"
CPU_THRESHOLD=50
MEM_THRESHOLD=50

# Function to log processes exceeding thresholds
print_fancy_header() {
    echo "__________                                                  ____ ___   __  .__.__  .__                __  .__               " >> $LOGFILE
    echo "\______   \ ____   __________  __ _________   ____  ____   |    |   \_/  |_|__|  | |__|____________ _/  |_|__| ____   ____  " >> $LOGFILE
    echo " |       _// __ \ /  ___/  _ \|  |  \_  __ \_/ ___\/ __ \  |    |   /\   __\  |  | |  \___   /\__  \\\\   __\  |/  _ \ /    \ " >> $LOGFILE
    echo " |    |   \  ___/ \___ (  <_> )  |  /|  | \/\  \__\  ___/  |    |  /  |  | |  |  |_|  |/    /  / __ \|  | |  (  <_> )   |  \\" >> $LOGFILE
    echo " |____|_  /\___  >____  >____/|____/ |__|    \___  >___  > |______/   |__| |__|____/__/_____ \(____  /__| |__|\____/|___|  /" >> $LOGFILE
    echo "        \/     \/     \/                         \/    \/                                   \/     \/                    \/ " >> $LOGFILE
}
inspect_resources() {
    date +"%Y-%m-%d %H:%M:%S" > ./datetime.tmp
    datetime=$( cat ./datetime.tmp )
    echo "Resource utilization report: " $datetime >> $LOGFILE
    echo "-----------------------------------" >> $LOGFILE

    # Get a list of all running processes
    ps aux > ./processes.txt

    # Filter the list of processes by CPU and memory usage
    # headers
    head -1 ./processes.txt > ./filtered_processes.txt
    # Create filtered_processes
    awk -v cpu_threshold=$CPU_THRESHOLD -v mem_threshold=$MEM_THRESHOLD '$3 > cpu_threshold || $4 > mem_threshold {print $0}' ./processes.txt >> ./filtered_processes.txt

    # If processes over either limit are found then echo a warning message to stdout
    linecount=$( cat -n ./filtered_processes.txt | tail -1 | awk '{print $1}' )
    adjusted_count=$((linecount - 1))
    if [ $adjusted_count -gt 0 ]; then
        echo "warning: Processes with CPU or MEM above limit were identified! Look in $LOGFILE"
    fi

    # Log the filtered list of processes
    echo "Processes above thresholds follow. CPU_THRESHOLD is " $CPU_THRESHOLD " and MEM_THRESHOLD is " $MEM_THRESHOLD >> $LOGFILE
    cat ./filtered_processes.txt >> $LOGFILE

    # Remove the temporary files
    # rm ./processes.txt ./filtered_processes.txt

    echo "-----------------------------------" >> $LOGFILE
}

print_fancy_header
inspect_resources
# Comment the above and uncomment the below to Check every minute (to avoid having to use cron. Cron is what I'd recommend, though.)
# while true; do
#     inspect_resources
#     sleep 60  # Sleep for 60 seconds
# done