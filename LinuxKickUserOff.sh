#!/bin/bash

# Import statements (assuming DontEdit.py is in the same directory)
. DontEdit.sh

# Check if the user has SSH running
if [ "$(uname)" == "Linux" ]; then
    is_ssh_enabled() {
        systemctl status ssh > /dev/null 2>&1
    }
else
    is_ssh_enabled() {
        launchctl list | grep -q "ssh"
    }
fi

if is_ssh_enabled; then
    echo "SSH is enabled"
else
    echo "SSH is not enabled"
    exit 0
fi

# NSLOOKUP function
NSLOOKUP() {
    read -p "Enter the domain to lookup: " nslookup
    output_file="nslookup.txt"

    {
        nslookup $nslookup
        nslookup $nslookup >> $output_file
    } 2>&1 | tee -a $output_file

    echo "nslookup output saved to $output_file"
}

# Kick function
Kick() {
    read -p "Enter the IP address of the user you want to kick off: " ip_address
    pid=$(netstat -tnpa | awk -v ip="${ip_address}" '$6 == "ESTABLISHED" && $5 ~ ip {split($7,a,"/"); print a[1]}')

    if [ -n "$pid" ]; then
        sudo kill $pid
        echo "SSH session associated with ${ip_address} has been terminated."
        echo "We have kicked ${ip_address} off your computer" | tee -a KICKED_USERS.txt
        if [ "$(uname)" == "Linux" ]; then
            read -p "Do you want to turn off ssh (yes/no)? " ssh
            if [ "${ssh}" == "yes" ]; then
                sudo service ssh stop
                sleep 2
                sudo service ssh status
            else
                echo "Ok SSH will still run"
            fi
        else
            exit 1
        fi
    else
        echo "No active SSH session found for IP address $ip_address"
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
                Kick
                ;;
            *)
                echo "I don't understand what you meant by '${nslookupOrKick}'. Please try again."
                exit 1
                ;;
        esac
    fi
}

# Trap Ctrl+C to exit
trap 'echo "Exiting program..."; exit' SIGINT

# Call the main function
main

