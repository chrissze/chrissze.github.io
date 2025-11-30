
# USE PLAYBOOK TO INSTALL XFCE4 IS FINE, BUT I CANNOT SEE THE LONG INSTALL PROCESS.

# USING SHELL SCRIPT IS CLEARER AND IT SHOWS INTERACTIVE QUESTIONS DURING THE INSTALL.



touch /home/debian/.xsession

echo "startxfce4" > /home/debian/.xsession



touch /home/debian/.xinitrc

echo "exec startxfce4" > /home/debian/.xinitrc


sudo apt install dbus-x11 xrdp xorgxrdp xfce4 xfce4-goodies


sudo firewall-cmd --permanent --zone=public --add-port=3389/tcp

sudo firewall-cmd --reload

sudo systemctl enable --now xrdp
