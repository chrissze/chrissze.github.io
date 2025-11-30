
# DO NOT USE PLAYBOOK TO INSTALL XFCE4, IT WILL STUCK AT apt install DUE TO INTERACTIVE QUESTIONS DURING THE INSTALL.



touch /home/debian/.xsession

echo "startxfce4" > /home/debian/.xsession



touch /home/debian/.xinitrc

echo "exec startxfce4" > /home/debian/.xinitrc



sudo apt install xrdp xorgxrdp xfce4 xfce4-goodies


sudo firewall-cmd --permanent --zone=public --add-port=3389/tcp


