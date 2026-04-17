#!/bin/bash
echo "=== Server Info ==="
echo "Hostname: $(hostname)"
echo "IP: $(curl -s ifconfig.me)"
echo "RAM: $(free -h | grep Mem | awk '{print $4}') free"
echo "Disk: $(df -h / | tail -1 | awk '{print $4}') free"
echo "Uptime: $(uptime -p)"
