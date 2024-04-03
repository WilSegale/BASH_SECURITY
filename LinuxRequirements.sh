#!/bin/bash
source DontEdit.sh
requiredments(){
# Check if the OS is Linux
if [[ "${OSTYPE}" == "${Linux}"* ]]; then
    if ping -c 1 google.com >/dev/null 2>&1; then
        # Function to install package using apt package manager
        install_linux_package() {
            package_name="$1"
            sudo apt-get install "${package_name}" -y
            echo -e "[ ${GREEN}OK${NC} ] ${package_name} installed successfully."
        }

        # Install APT packages
        for package in "${Packages[@]}"; do
            install_linux_package "${package}"
        done

        echo "All packages installed successfully."

    else
        echo -e "[ ${RED}FAIL${NC} ] NOT CONNECTED TO THE INTERNET"
    fi
else
    echo -e "[ ${RED}FAIL${NC} ] Wrong OS, please use the correct OS."
fi
}
requiredments
