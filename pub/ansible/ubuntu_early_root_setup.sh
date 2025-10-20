#/bin/bash

# Both Ubuntu and Debian support 'apt full-upgrade', it will aggressively remove packages for resolutions, but 'apt upgrade' will NOT remove obsolete packages. 


apt update && apt upgrade -y && apt autoremove -y && apt clean

apt install ansible -y 
