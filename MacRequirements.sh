#!/bin/bash
source DontEdit.sh

# Check if the script is run with --help or -h
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    figlet "? HELP ?"
    echo "This script will install the required packages for the script."
    exit 1
fi

# Function to install the required packages
requiredments() {
    # Checks if the user is ROOT and prompts them not to use sudo
    if [ "$(id -u)" -eq 0 ]; then
        # Puts the ERROR message into line art
        echo -e "${RED}$(figlet ERROR)${NC}"

        # Gives the user something to read so they understand why they got the error
        echo "+++++++++++++++++++++++++++++++++++++++++"
        echo "+   Don't use sudo for this script.     +"
        echo "+   Because it can damage your computer +"
        echo "+++++++++++++++++++++++++++++++++++++++++"
        exit 1
    else
        # Check if the OS is macOS
        if [[ "${OSTYPE}" == "darwin"* ]]; then
            if ping -c 1 google.com >/dev/null 2>&1; then
                # Install package using Homebrew package manager
                install_brew_package() {
                    package_name="$1"
                    if ! command -v "${package_name}" >/dev/null 2>&1; then
                        brew install "${package_name}"
                    else
                        echo -e "[ ${GREEN}OK${NC} ] ${package_name} is already installed."
                    fi
                }

                echo
                echo "_________BREW PACKAGES________"

                # Install Homebrew packages
                for package in "${Packages[@]}"; do
                    install_brew_package "${package}"
                done

                echo
                successful_MESSAGE="[ ${GREEN}OK${NC} ] All packages are installed successfully"
                echo "_________FINISH________"

                echo -e "${successful_MESSAGE}"
            else
                echo -e "[ ${RED}FAIL${NC} ] NOT CONNECTED TO THE INTERNET"
            fi
            # Function to check if a package is installed
            check_package() {
                if brew list "$1" &> /dev/null; then
                    echo "$1 is installed."
                else
                    echo "Package $1 is not installed."
                fi
            }

            # Loop through each package and check its status
            for pkg in "${packages[@]}"; do
                check_package "${pkg}"
            done
        else
            echo -e "[ ${RED}FAIL${NC} ] Wrong OS, please use the correct OS." # If the user is not using the right OS, it says "You are using the wrong OS"
        fi
    fi
}

requiredments
