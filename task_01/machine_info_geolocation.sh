#!/bin/bash

# Author: Yusuf Kaya
# Crated date: 06/09/2023
# Modified date: 09/09/2023

# Description
# You will create and run a shell script that collects machine information
# Performs geolocation using an API, and saved the results in a JSON file. 
# This script demonstrates your ability to automate tasks and work with external APIs in a shell environment.

# Usage
# ./machine_info_geolocation.sh

new_line() {
	echo ""
	sleep 2
}

# Collects machine information
new_line
echo "---------------------------------"
echo "Collecting Machine Information..."
echo "---------------------------------"
new_line

# Machine information
echo "╔══════════════════════════════════════╗"
echo "║   Machine Information                ║"
echo "╟──────────────────────────────────────╢"
echo "║ Date: $(date)"
echo "║ Username: $(whoami)"
echo "║ User ID: $(id -u)"
echo "║ Group ID: $(id -g)"
echo "║ Home Directory: $(echo $HOME)"
echo "║ Password Change: $(chage -l $USER | grep 'Last password change' | cut -d':' -f2)"
echo "║ User Groups: $(groups)"
echo "║ Last User: $(lastlog | grep -v 'Never' | cut -d' ' -f1 | tail -n1)"
echo "╚══════════════════════════════════════╝"
new_line

# System information
echo "╔══════════════════════════════════════╗"
echo "║   System Information                 ║"
echo "╟──────────────────────────────────────╢"
echo "║ Karnel Name: 		$(uname -s)"
echo "║ Node Name: 			$(uname -n)"
echo "║ Karnel Release: 	$(uname -r)"
echo "║ Karnel Version: 	$(uname -v)"
echo "║ Machine Hardware: 	$(uname -m)"
echo "║ Processor: 			$(uname -p)"
echo "║ Hardware Platform:  $(uname -i)"
echo "║ Operating System: 	$(uname -o)"
echo "║ Up Time: 			$(uptime -p)"
echo "╚══════════════════════════════════════╝"
new_line

# CPU information
echo "╔══════════════════════════════════════╗"
echo "║   CPU Information                    ║"
echo "╟──────────────────────────────────────╢"
echo "║ CPU Architecture:  $(lscpu | grep 'Architecture' | tr -s ' ')"
echo "║ CPU op-mode(s):  $(lscpu | grep 'op-mode(s)' | tr -s ' ')"
echo "║ CPU Model name:  $(lscpu | grep 'Model name' | tr -s ' ')"
echo "║ CPU Family:  $(lscpu | grep 'CPU family' | tr -s ' ')"
echo "╚══════════════════════════════════════╝"
new_line


# Memory information
echo "╔══════════════════════════════════════╗"
echo "║   Memory Information                 ║"
echo "╟──────────────────────────────────────╢"
echo "║  Total Memory:  $(free -h | grep 'Mem' | tr -s ' ' | cut -d' ' -f2)"
echo "║  Used Memory:  $(free -h | grep 'Mem' | tr -s ' ' | cut -d' ' -f3)"
echo "║  Free Memory:  $(free -h | grep 'Mem' | tr -s ' ' | cut -d' ' -f4)"
echo "║  Shared Memory:  $(free -h | grep 'Mem' | tr -s ' ' | cut -d' ' -f5)"
echo "║  Buff/Cache:  $(free -h | grep 'Mem' | tr -s ' ' | cut -d' ' -f6)"
echo "║  Available Memory:  $(free -h | grep 'Mem' | tr -s ' ' | cut -d' ' -f7)"
echo "╚══════════════════════════════════════╝"
new_line


# Network information
echo "╔══════════════════════════════════════╗"
echo "║   Networking Information             ║"
echo "╟──────────────────────────────────────╢"
echo "║ Ip Address: $(hostname -I)"
echo "║ Internet IP Address: $(curl -s ifconfig.me)"
echo "║ Gateway Address: $(route -n | grep 'UG' | tr -s ' ' | cut -d' ' -f2)"
echo "║ DNS Server IP Address: $(cat /etc/resolv.conf | grep 'nameserver' | tr -s ' ' | cut -d' ' -f2)"
echo "║ MAC Address: $(ip a show eth0 | grep 'link/ether' | tr -s ' ' | cut -d' ' -f3)"
echo "╚══════════════════════════════════════╝"
new_line


echo "---------------------------------"
echo "Collecting GeoLocation Information..."
echo "---------------------------------"
new_line


# Get IP address
ip_address=$(curl -s ifconfig.me/ip)
# Get GeoLocation information
geo_location=$(curl -s https://ipinfo.io/$ip_address/json)
# Get GeoLocation information


# GeoLocation information
echo "╔══════════════════════════════════════╗"
echo "║   GeoLocation Information            ║"
echo "╟──────────────────────────────────────╢"
echo "║ IP Address: $(echo $geo_location | jq -r '.ip')"
echo "║ City: $(echo $geo_location | jq -r '.city')"
echo "║ Region: $(echo $geo_location | jq -r '.region')"
echo "║ Country: $(echo $geo_location | jq -r '.country')"
echo "║ Location: $(echo $geo_location | jq -r '.loc')"
echo "║ Organization: $(echo $geo_location | jq -r '.org')"
echo "║ Postal: $(echo $geo_location | jq -r '.postal')"
echo "║ Timezone: $(echo $geo_location | jq -r '.timezone')"
echo "╚══════════════════════════════════════╝"
echo "$geo_location" > machine_info.json