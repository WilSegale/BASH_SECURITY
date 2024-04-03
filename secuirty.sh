#!/bin/bash


source DontEdit.sh

function scan(){

    read -p "Auto mode or Manule: " autoOrMan
    # gets a argument in a auto array
    if [[ " ${autoOrMan[*]} " == *" ${auto} "* ]]; then
        echo "Auto mode"
        nmap --script=malware -Pn 192.168.1.1/24

    # gets a argument in a manule array
    elif [[ " ${autoOrMan[*]} " == *" ${manule} "* ]]; then
        echo "Manule mode."
        read -p "Enter the ip: " ip
        read -p "Enter the port: " port
        nmap --script=malware "${port}" -p "${ip}"
    else
        echo "ERROR"
        scan
    fi
}
scan