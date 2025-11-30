#/bin/bash

# Both Ubuntu and Debian support apt full-upgrade.

# 'apt upgrade' upgrades packages without removing any; it may install new dependencies but skips upgrades that require removals.

# 'apt full-upgrade' can add/remove packages to complete upgrades. Use apt autoremove to remove obsolete dependencies.


apt update && apt upgrade -y && apt autoremove -y && apt clean

apt install ansible git needrestart nmap -y 

needrestart -r a

# CHECK FIREWALL

systemctl status firewalld  # pre-installed on OVH Debian 13

systemctl status ufw

firewall-cmd --list-all  #  active services: dhcpv6-client ssh





# MANUALLY EDIT
  # add ~/.ssh/id_rsa   (400, owned by debian user, for git clone)
  # mkdir /github   (owned by debian user)
  # git clone chris
