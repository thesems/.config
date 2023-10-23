#!/usr/bin/env bash

# Initialize SSH
eval $(ssh-agent)
ssh-add ~/.ssh/id_rsa

# Clear the terminal
clear

# Get system information
current_time=$(date +"%Y-%m-%d %H:%M:%S")
os_info=$(lsb_release -d | awk -F"\t" '{print $2}')
cpu_info=$(lscpu | grep "Model name:" | awk -F":" '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//')
ram_info=$(free -h --giga | awk '/^Mem:/ {print $2 "B"}')
disk_info=$(df -h / | awk '/\// {print $4 "B"}')

# ANSI Colors
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Print details in formatted manner
echo -e "${GREEN}SSH is loaded.${NC}"

# Launch a new shell
exec $SHELL
