#!/bin/bash

Linux="linux"
MacOS="darwin"

RED='\033[0;31m'
GREEN='\033[0;32m'
BRIGHT='\033[1m'
NC='\033[0m' # No Color


auto=(
    "auto"
    "Auto"
    "AUTO"
    "Automatic"
    "automatic"
)

manule=(
    "man"
    "Man"
    "MAN"
    "Manual"
    "manual"
    "MANUAL"
)

#List of required packages/commands (separated by spaces)
required_packages=("nmap")

# list of required packages for the program to work 
# Packages to install
Packages=(
    "nmap"
)