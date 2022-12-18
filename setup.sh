#!/bin/bash

# Run using
# $ curl https://raw.githubusercontent.com/Stefanomarton/SMABS/master/setup.sh | sh

# Yay Installing
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
sudo chown -R stefanomarton:users yay
makepkg -si
echo "Agg' installlat yay"

pacman=(
    nvim
		)

yay=(
		spotify
		)

# Installing packages, use pacman -Qqe > pkglist.txt to create the list

sudo pacman -S --noconfirm ${pacman[@]}
yay -S --noconfirm ${yay[@]}

# DotFiles 
# cd ..
# git clone --recursive https://github.com/Stefanomarton/DotFiles.git && cd DotFiles && stow . 
#
# # Fonts configuration
# sudo cp -r ~/Media/Fonts/JetBrainsMono/ /usr/share/fonts/


