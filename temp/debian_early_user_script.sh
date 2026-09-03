#/bin/bash

# THIS SCRIPT MUST BE RUN BY A NON-ROOT USER.


git config --global user.email "cs@9-4.com"

git config --global user.name "CS"



# must run locally with GUI
gsettings set org.gnome.shell.app-switcher current-workspace-only true

gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

# Turn off screen automatically after 1 hour.
gsettings set org.gnome.desktop.session idle-delay 3600

gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'




# FLATPAK
    # Go to flathub.org and search "vscodium"
    # RUN CODIUM AFTER INSTALL: flatpak  run  com.vscodium.codium

    # add repo if i have not:
    # sudo flatpak  remote-add  --if-not-exists  flathub  https://dl.flathub.org/repo/flathub.flatpakrepo

    # REMOVE keyring file after install, then I input a short keyring on first login.
    # rm  ~/.local/share/keyrings/login.keyring

flatpak  install  flathub  com.vscodium.codium
