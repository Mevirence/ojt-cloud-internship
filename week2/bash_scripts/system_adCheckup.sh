#!/bin/bash

# SYSTEM HEALTH REPORT SCRIPT
# This script checks:
# 1. Memory Usage
# 2. Disk Usage
# 3. System Load Average
#
# It displays a warning if memory or disk usage exceeds 80%, otherwise it
# displays OK.



echo "SYSTEM HEALTH REPORT"
echo

# Memory Check
# The free command displays memory statistics
# awk searches for the line beginning with Mem: and calculates:
# used memory / total memory * 100
# The final percentage is stored in the variable memory_used
memory_used=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')

# Check whether memory usage exceeds 80%
# -gt means greater than
if [ "$memory_used" -gt 80 ]; then
        echo "WARNING: Memory usage is ${memory_used}%"
else
        echo "OK: Memory usage is ${memory_used}%"
fi

echo

# Disk Check
# The df / command displays disk usage info
# for the root (/) filesystem.
# NR==2 tells awkl to process only the second line
# because the first line contains column headers
# $5 refers to the 5th column
# gsub (5, ) removes the percent sign so the
# value can be compared as a number
# The resulting disk usage percentage is stored
# in the variable disk_used
disk_used=$(df / | awk 'NR==2 {gsub("%", ""); print $5}')

# Check whether disk usage exceeds 80%
if [ "$disk_used" -gt 80 ]; then
        echo "WARNING: Disk usage is ${disk_used}%"
else
        echo "OK: Disk usage is ${disk_used}%"
fi

echo

# Load Check
# uptime displays: current time, how long the system has been running
# , number of logged-in users, and load averages
#
# -F sets the field seperator to - load average:
# so awk splits the line into two parts
#
# {print $2} prints everything after
# load average:
#
# The resulting value is stored in the variable load
load=$(uptime | awk -F'load average:' '{print $2}')

# Display the system load averages
#
# The three numbers represents - 1 minute average, 5 minute average
#, 15 minute average
#
#Lower values generally indicate less CPU demand
echo "Current Load Average:$load"
