#!/bin/bash

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
NC='\033[0m' # No Color

# Print details in formatted manner
printf "${YELLOW} ⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡${NC}\n"
printf "${YELLOW}⚡ ${NC}%-20s  ${BLUE}%-40s${YELLOW}  ⚡${NC}\n" "Time" "$current_time"
printf "${YELLOW}⚡ ${NC}%-20s  ${BLUE}%-40s${YELLOW}  ⚡${NC}\n" "Operating System" "$os_info"
printf "${YELLOW}⚡ ${NC}%-20s  ${BLUE}%-40s${YELLOW}  ⚡${NC}\n" "CPU" "$cpu_info"
printf "${YELLOW}⚡ ${NC}%-20s  ${BLUE}%-40s${YELLOW}  ⚡${NC}\n" "RAM" "$ram_info"
printf "${YELLOW}⚡ ${NC}%-20s  ${BLUE}%-40s${YELLOW}  ⚡${NC}\n" "Disk" "$disk_info"
printf "${YELLOW} ⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡${NC}\n"
echo -e "${GREEN}SSH is loaded! Enjoy your session, sir!${NC}"

# Launch a new shell
exec $SHELL
