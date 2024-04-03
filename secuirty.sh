source DontEdit.sh

function scan(){

    read -p "Auto mode or Manule: " autoOrMan
    # gets a argument in a auto array
    if [[ " ${autoOrMan[*]} " == *" ${auto} "* ]]; then
        echo "Auto mode"
        read -p "Enter the ip: " ip
        nmap -sS --script=malware 192.168.1.1/24
    # gets a argument in a manule array
    elif [[ " ${autoOrMan[*]} " == *" ${manule} "* ]]; then
        echo "Manule mode"
        read -p "Enter the ip: " ip
        nmap --script=malware "${ip}"
    else
        echo "ERROR"
    fi
}
scan