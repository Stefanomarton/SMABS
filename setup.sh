#!/bin/bash
sudo pacman -S ansible ansible-core &&
ansible-galaxy collection install community.general &&
sudo ansible-pull -U https://github.com/Stefanomarton/SMABS.git &&
echo "Agg' fatto con paccheman ed ansibble"
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
echo "Agg' installlat yay"
yay -S ferdium nerd-font-complete ptsh ncspot teams-for-linux update-grub ttf-ms-win11-auto simple-usb-automount dracula-cursors-git dracula-gtk-theme-git dracula-icons-git
