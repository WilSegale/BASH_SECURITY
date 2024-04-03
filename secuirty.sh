#!/bin/bash
source DontEdit.sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to handle cleanup on exit
# quits program with ctrl-c
EXIT_PROGRAM_WITH_CTRL_C() {
    echo -e "${RED}[-]${NC} EXITING SOFTWARE..."
    
    # Adds a cleanup commands here
    exit 1
}

# quits program with ctrl-z
EXIT_PROGRAM_WITH_CTRL_Z(){
    echo ""
    echo -e "${RED}[-]${NC} EXITING SOFTWARE..."
    # Add cleanup commands here
    exit 1
}

# Function to be executed when Ctrl+Z is pressed
handle_ctrl_z() {
    EXIT_PROGRAM_WITH_CTRL_Z
    exit 1
    # Your custom action goes here
}

# Set up the trap to call the function on SIGTSTP (Ctrl+Z)
trap 'handle_ctrl_z' SIGTSTP

# Function to handle Ctrl+C
ctrl_c() {
    echo ""
    EXIT_PROGRAM_WITH_CTRL_C
}

trap ctrl_c SIGINT

function scan(){

    read -p "Auto/Manule: " AutoOrManule
    # gets a argument in a auto array
    if [[ " ${AutoOrManule[*]} " == *" ${auto} "* ]]; then
        echo -e "[ ${GREEN}OK${NC} ] Auto mode"
        nmap --script=malware -Pn 192.168.1.1/24

    # gets a argument in a manule array
    elif [[ " ${AutoOrManule[*]} " == *" ${manule} "* ]]; then
        echo -e "[ ${GREEN}OK${NC} ] Manule mode"
        read -p "Enter the ip: " ip
        read -p "Enter the port: " port
        nmap --script=malware "${ip}" -p "${port}" 
    #eror message
    else
        echo -e "[ ${RED}FAIL${NC} ] Wrong argument"
        scan
    fi
}
scan