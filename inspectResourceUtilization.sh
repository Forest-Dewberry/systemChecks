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

LOGFILE="/var/log/resource_inspection.log"
CPU_THRESHOLD=50
MEM_THRESHOLD=50

# Function to log processes exceeding thresholds
inspect_resources() {
    echo " __________                                                  ____ ___   __  .__.__  .__                __  .__               
" >> $LOGFILE
    echo " \______   \ ____   __________  __ _________   ____  ____   |    |   \_/  |_|__|  | |__|____________ _/  |_|__| ____   ____  
" >> $LOGFILE
    echo " |       _// __ \ /  ___/  _ \|  |  \_  __ \_/ ___\/ __ \  |    |   /\   __\  |  | |  \___   /\__  \\   __\  |/  _ \ /    \ 
" >> $LOGFILE
    echo " |    |   \  ___/ \___ (  <_> )  |  /|  | \/\  \__\  ___/  |    |  /  |  | |  |  |_|  |/    /  / __ \|  | |  (  <_> )   |  \
" >> $LOGFILE
    echo " |____|_  /\___  >____  >____/|____/ |__|    \___  >___  > |______/   |__| |__|____/__/_____ \(____  /__| |__|\____/|___|  /
" >> $LOGFILE
    echo "        \/        \/        \/          \/     \/     \/                         \/    \/                                   \/     \/                    \/ " >> $LOGFILE
    echo "Resource utilization report:" >> $LOGFILE
    echo "---------------------------------------------------" >> $LOGFILE

    # Print the headers
    printf "%-10s %-10s %-50s %-6s %-6s\n 
}

while true; do
    inspect_resources
    sleep 60 # sleeps for 60 sec
done