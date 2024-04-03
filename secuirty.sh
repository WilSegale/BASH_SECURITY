#!/bin/bash


source DontEdit.sh

function scan(){

    read -p "Auto mode or Manule: " autoOrMan
    # gets a argument in a auto array
    if [[ " ${autoOrMan[*]} " == *" ${auto} "* ]]; then
        echo "Auto mode"
        sleep 1
        nmap --script=malware 192.168.1.1/24

    # gets a argument in a manule array
    elif [[ " ${autoOrMan[*]} " == *" ${manule} "* ]]; then
        echo "Manule mode"
        read -p "Enter the ip: " ip
        sleep 1
        nmap --script=malware "${ip}"
    else
        echo "ERROR"
        scan
    fi
}
scan