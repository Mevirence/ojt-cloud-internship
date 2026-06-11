#!/bin/bash

echo ===============================
echo "  System Health Checkup   "
echo ===============================

# Displays the host's name
echo "Hostname:"
hostname
echo

sleep 1
echo "Current Date & Time:"
date
echo

sleep 1
echo "System Uptime:"
uptime -p
echo

sleep 1
echo "------------------------------"
echo "          CPU Load            "
echo "------------------------------"
uptime
echo

sleep 1
echo "------------------------------"
echo "         Memory Usage         "
echo "------------------------------"
free -h
echo

sleep 1
echo "------------------------------"
echo "         Disk Usage           "
echo "------------------------------"
df -h
echo

sleep 1
echo "------------------------------"
echo "        Logged in Users       "
echo "------------------------------"
who
echo

sleep 1
echo "--------------------------------"
echo "Top 5 Memory-Consuming Processes"
echo "--------------------------------"
ps aux --sort=-%mem | head -6
echo

sleep 1
echo "------------------------------"
echo "    Health Check Complete     "
echo "------------------------------"
