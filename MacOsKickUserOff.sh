#!/bin/bash

# Function to check if SSH is enabled on macOS
is_ssh_enabled() {
    launchctl list | grep -q "com.openssh.sshd"
}

# Function to check if SSH is enabled on Linux
is_ssh_enabled_linux() {
    systemctl status ssh | grep -q "active (running)"
}

# Function to perform an nslookup and save the output to a file
NSLOOKUP() {
    read -p "Enter the domain to lookup: " nslookup
    output_file="nslookup.txt"

    {
        nslookup $nslookup
        nslookup $nslookup >> $output_file
    } 2>&1 | tee -a $output_file

    echo "nslookup output saved to $output_file"
}

# Function to get the PID of an SSH session associated with an IP address
get_ssh_pid() {
    ip_address=$1
    netstat -tnpa | awk -v ip="$ip_address" '$6 == "ESTABLISHED" && $5 ~ ip {split($7,a,"/"); print a[1]}'
}

# Function to kick a user off the computer by terminating their SSH session
kick_user() {
    ip_address=$1
    pid=$(get_ssh_pid $ip_address)

    if [ -n "$pid" ]; then
        sudo kill $pid
        echo "SSH session associated with $ip_address has been terminated."
        echo "We have kicked $ip_address off your computer" | tee -a KICKED_USERS.txt
        read -p "Do you want to turn off ssh (yes/no)? " ssh
        if [ "${ssh}" == "yes" ]; then
            sudo service ssh stop
            sleep 2
            sudo service ssh status
        else
            echo "Ok SSH will still run"
        fi
    else
        echo "No active SSH session found for IP address ${ip_address}"
    fi
}

# Main function
main() {
    if [ "$(id -u)" != "0" ]; then
        echo "This script requires sudo privileges to run."
        exit 1
    else
        who
        read -p "Do you want to nslookup or kick a user? (nslookup/kick): " nslookupOrKick

        case "$nslookupOrKick" in
            "nslookup")
                NSLOOKUP
                exit 0
                ;;
            "kick")
                read -p "Enter the IP address of the user you want to kick off: " ip_address
                kick_user $ip_address
                ;;
            *)
                echo "I don't understand what you meant. Please try again."
                exit 1
                ;;
        esac
    fi
}

# Trap Ctrl+C to exit
trap 'echo "Exiting program..."; exit' SIGINT

# Script execution
main

