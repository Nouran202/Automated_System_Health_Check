#!/bin/bash

# Define color variables for colored output
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
NC="\e[0m"  # No Color (reset)

# Function to check CPU Load
function check_cpu() {
    echo -e "${YELLOW}Checking CPU ...${NC}"
    
    # Get CPU load averages
    LOAD=$(uptime | awk -F 'load average:' '{print $2}')
    echo -e "${YELLOW}Your CPU Load is $LOAD${NC}"

    # Define thresholds
    SAFE_THRESHOLD=0.5
    AVERAGE_THRESHOLD=1
    WARNING_THRESHOLD=2

    # Extract the first load value and clean spaces
    LOAD_VALUE=$(echo "$LOAD" | cut -d',' -f1)
    LOAD_VALUE=$(echo $LOAD_VALUE | sed 's/^[ \t]*//;s/[ \t]*$//')

    # Compare load value with thresholds
    if (( $(echo "$LOAD_VALUE < $SAFE_THRESHOLD" | bc -l) )); then
        echo -e "${GREEN}Your CPU is safe${NC}"
    elif (( $(echo "$LOAD_VALUE < $AVERAGE_THRESHOLD" | bc -l) )); then
        echo -e "${YELLOW}Your CPU is in average use${NC}"
    elif (( $(echo "$LOAD_VALUE < $WARNING_THRESHOLD" | bc -l) )); then
        echo -e "${RED}CPU IS IN WARNING STATE${NC}"
    else
        echo -e "${RED}DANGER!! CPU LOAD IS VERY HIGH${NC}"
    fi
}

# Function to check Memory Usage
function check_memory_usage() {
    echo -e "${YELLOW}Checking Memory Usage...${NC}"

    # Get total and used memory info
    Mem_Info=$(free -m | grep Mem)
    Mem_Total=$(echo $Mem_Info | awk '{print $2}')
    Mem_Used=$(echo $Mem_Info | awk '{print $3}')

    # Calculate memory usage percentage
    Mem_Usage_Percent=$(echo "scale=2; ($Mem_Used/$Mem_Total)*100" | bc)

    echo -e "${YELLOW}Memory Usage Percent is: $Mem_Usage_Percent%${NC}"

    # Define thresholds
    SAFE_THRESHOLD=50
    WARNING_THRESHOLD=75
    DANGER_THRESHOLD=90

    # Compare memory usage with thresholds
    if (( $(echo "$Mem_Usage_Percent < $SAFE_THRESHOLD" | bc -l) )); then 
        echo -e "${GREEN}Your Memory Usage is Safe${NC}"
    elif (( $(echo "$Mem_Usage_Percent < $WARNING_THRESHOLD" | bc -l) )); then
        echo -e "${YELLOW}Your Memory Usage is moderate${NC}"
    elif (( $(echo "$Mem_Usage_Percent >= $DANGER_THRESHOLD" | bc -l) )); then
        echo -e "${RED}Your Memory Usage is HIGH!!${NC}"
    fi
}

# Function to check Running Services
function check_running_services() {
    echo -e "${YELLOW}Checking Running Services...${NC}"

    # List all active (running) services
    RUNNING_SERVICES=$(systemctl list-units --type=service --state=running)

    if [[ -z "$RUNNING_SERVICES" ]]; then
        echo -e "${RED}No running services found.${NC}"
    else
        echo -e "${YELLOW}These services are currently running:${NC}"

        # Print each running service name
        echo -e "$RUNNING_SERVICES" | awk '{print $1}' | tail -n +2 | while read service; do
            echo -e "${BLUE}$service${NC}"
        done
    fi
}

# Function to check Open Network Ports
function check_open_ports() {
    echo -e "${YELLOW}Checking Open Network Ports...${NC}"

    # List open (listening) ports using 'ss'
    OPEN_PORTS=$(ss -tuln)

    if [[ -z "$OPEN_PORTS" ]]; then
        echo -e "${RED}No open ports found.${NC}"
    else
        echo -e "${YELLOW}These ports are currently open:${NC}"

        # Print each open port information
        echo "$OPEN_PORTS" | tail -n +2 | while read line; do
            echo -e "${GREEN}$line${NC}"
        done
    fi
}

# Main execution
check_cpu
check_memory_usage
check_running_services
check_open_ports
