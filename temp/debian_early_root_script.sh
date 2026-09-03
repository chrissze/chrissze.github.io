#/bin/bash

# Both Ubuntu and Debian support apt full-upgrade.

# 'apt upgrade' upgrades packages without removing any; it may install new dependencies but skips upgrades that require removals.

# 'apt full-upgrade' can add/remove packages to complete upgrades. Use apt autoremove to remove obsolete dependencies.


apt  update  &&  apt  upgrade  -y  &&  apt  autoremove  -y  &&  apt  clean

apt  install  ansible  git  needrestart  nmap  -y 


# add cs to sudo group, /usr/sbin is not in root PATH
/usr/sbin/usermod  -aG  sudo  cs


## FLATPAK
apt  install  flatpak  -y 

apt  install  gnome-software-plugin-flatpak  -y

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# TIME SYNC
apt  install  systemd-timesyncd

timedatectl  set-ntp  true


needrestart  -r  a

# CHECK FIREWALL

systemctl status firewalld  # pre-installed on OVH Debian 13

systemctl status ufw

firewall-cmd --list-all  #  active services: dhcpv6-client ssh





# MANUALLY EDIT
  # add ~/.ssh/id_rsa   (400, owned by debian user, for git clone)
  # mkdir /github   (owned by debian user)
  # git clone chris
