# SSH Management Bash Script README

## Overview
This Bash script helps manage SSH (Secure Shell) connections on computers running macOS or Linux. It offers simple options to perform tasks like checking if SSH is enabled, looking up domain names, and kicking users off the computer if needed.

## Prerequisites
Before using this script, ensure the following:
- You have permission to run commands with elevated privileges (typically, using `sudo`).
- You can open a terminal or command prompt on your computer.
- No prior knowledge of scripting or coding is required.

## How to Use
1. **Open a Terminal or Command Prompt**: Locate the terminal application on your computer and open it.

2. **Run the Script**: Type `./script.sh` and press Enter. This command will execute the script.

3. **Follow the Prompts**: The script will ask you what you want to do. You can choose between looking up a domain name or kicking a user off the computer's SSH session.

4. **Perform Actions**: Depending on your choice, you'll either perform a DNS lookup or kick a user off the computer's SSH session. Follow the on-screen instructions for each action.

5. **Optional: Turn Off SSH**: If you choose to kick a user and are prompted, you can decide whether to turn off SSH after kicking the user. Respond with "yes" or "no" accordingly.

## Important Notes
- This script is designed to simplify SSH management tasks for users who may not be familiar with technical details.
- If you encounter any issues or errors, seek assistance from someone with technical expertise.
- Use caution when kicking users off SSH sessions, as it may disrupt their work.
- The script provides a basic interface for SSH management and may require adjustments to fit specific needs or system configurations.

## Disclaimer
This script is provided as-is without any guarantees. Use it responsibly and at your own risk.
