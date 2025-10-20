#/bin/bash

apt update && apt full-upgrade -y && apt autoremove -y && apt clean

apt install ansible -y 


