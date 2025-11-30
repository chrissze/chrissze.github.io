#/bin/bash

# Both Ubuntu and Debian support apt full-upgrade.

# 'apt upgrade' upgrades packages without removing any; it may install new dependencies but skips upgrades that require removals.

# 'apt full-upgrade' can add/remove packages to complete upgrades. Use apt autoremove to remove obsolete dependencies.


apt update && apt upgrade -y && apt autoremove -y && apt clean

apt install ansible git needrestart nmap -y 

needrestart -r a


# MIGHT NEED MANUALLY REBOOT
