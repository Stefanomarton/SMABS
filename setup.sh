#!/bin/bash

# Run using
# $ curl https://raw.githubusercontent.com/Stefanomarton/SMABS/master/setup.sh | sh

# Yay Installing
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
echo "Agg' installlat yay"

# Installing packages, use pacman -Qqe > pkglist.txt to create the list
# yay -S --needed - < pkglist.txt

yay -S alsa-utils android-tools anki archlinux-keyring autoconf automake autorandr avr-gcc base bat beautysh binutils bison bitwarden blueberry brightnessctl btop calibre carla cava chromium cloudflare-warp-bin cmake discord dkms efibootmgr element emacs espanso expac fakeroot ferdium figlet file findutils firefox firefox-tridactyl firefox-tridactyl-native flameshot flex font-manager fzf galculator gawk gcc gettext git glow gparted gpick grep groff grub gzip helix highlight htop hugo inotify-tools insync intel-ucode iwd joshuto kitty lazygit lib32-harfbuzz lib32-mesa libreoffice-fresh libtool libxcrypt-compat luarocks m4 maim make man-db nautilus nauty navi ncspot neovim neovim-remote network-manager-applet networkmanager ninja npm nushell-git obsidian octave os-prober p3x-onenote pandoc patch pavucontrol pcmanfm perl-eval-closure perl-file-homedir perl-log-dispatch perl-log-log4perl perl-namespace-autoclean perl-params-validationcompiler perl-perl-minimumversion perl-specio perl-try-tiny perl-unicode-linebreak perl-yaml-tiny picom-git pier pipewire pipewire-alsa pipewire-jack pipewire-pulse pkgconf playerctl ptsh pyright python-pillow python-pip python-pyalsa python-typer qmk qpwgraph ranger read-edid rip ripgrep rofi ruby sed simple-usb-automount sioyek sip spotify starship stow stylua sudo sway sxiv teams-for-linux tectonic texinfo ticktick topgrade ttf-ms-win10-auto ueberzug unzip update-grub which wireplumber wofi xarchiver xclip xdg-ninja xplr yaml-language-server yarn zaread-git zathura zathura-pdf-mupdf zoxide zram-generator zsh wl-clipboard hyprland-git

# DotFiles 
git clone --recursive https://github.com/Stefanomarton/DotFiles.git && cd DotFiles && stow . 

# Fonts configuration
cp -r ~/Media/Fonts/JetBrainsMono/ /usr/share/fonts/


