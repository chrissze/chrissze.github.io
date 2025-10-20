#/bin/bash

apt update && apt upgrade -y && apt autoremove -y && apt clean

apt install ansible -y 
