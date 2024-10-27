# remove unwanted packages

sudo dnf -y remove libreoffice* 

sudo dnf -y remove java-21-openjdk-headless

sudo dnf -y remove ibus

sudo dnf -y remove geolite2-city

sudo dnf -y remove gnome-user-docs

sudo dnf -y remove nvidia-gpu-firmware

sudo dnf -y remove skopeo # Container management tool; remove if not used.

# 20 MB
sudo dnf -y remove thunderbird rhythmbox cheese gnome-maps gnome-photos gnome-weather simple-scan  

# clean up
sudo dnf autoremove

