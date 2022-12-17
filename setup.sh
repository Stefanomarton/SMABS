#!/bin/bash

# Run using
# $ curl https://raw.githubusercontent.com/Stefanomarton/SMABS/master/setup.sh | sh

# Yay Installing
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
echo "Agg' installlat yay"

# Installing packages, use pacman -Qqe > pkglist.txt to create the list
yay -S --needed - < pkglist.txt

# DotFiles 
git clone --recursive https://github.com/Stefanomarton/DotFiles.git && cd DotFiles && stow . 

# Fonts configuration
cp -r ~/Media/Fonts/JetBrainsMono/ /usr/share/fonts/


