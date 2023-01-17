#!/bin/bash
# Run using $ curl https://raw.githubusercontent.com/Stefanomarton/SMABS/master/setup.sh | sh

echo 'Updating Applications'
sudo pacman -Syu

echo 'Cleaning caches and directories'
sudo pacman -Sc

echo 'Installing yay'
# Yay Installing
sudo pacman -S git base-devel
git clone https://aur.archlinux.org/yay.git
sudo chown -R stefanomarton:stefanomarton yay
cd yay
makepkg -si
cd
echo 'Installed yay'

pacman=(
    neovim
    zsh
    obsidian
    kitty
    ranger
    discord
    firefox
    code
    pcmanfm
    wofi
    waybar
    bitwarden
    code
    discord
    emacs
    feh
    flameshot
    fzf
    git-delta
    lazygit
    bat
    blueberry
    picom
    glow
    gparted
    gpick
    helix
    stow
    pipewire-alsa
    pipewire-jack
    pipewire-pulse
    rofi
    tectonic
    qmk
    zathura
    zathura-pdf-mupdf
    sxiv
    btop
    darktable
    pavucontrol
    python-pillow
    python-pip
    python-pyalsa
    python-typer
    ripgrep
    starship
    xclip
    thunderbird
    npm
    redshift
    noto-fonts-emoji
    xorg
    xorg-xsetroot
    hugo
)

yay=(
    ptsh
    cava
    insync
    ferdium
    swww
    espanso
    # git-credential-manager-core
    github-cli
    moar
    perl-eval-closure
    perl-file-homedir
    perl-log-dispatch
    perl-log-log4perl
    perl-namespace-autoclean
    perl-params-validationcompiler
    perl-perl-minimumversion
    perl-specio
    perl-try-tiny
    perl-unicode-linebreak
    perl-yaml-tiny
    zaread-git
    ncspot
    ticktick
    topgrade
)

# Installing packages, use pacman -Qqe > pkglist.txt to create the list

sudo pacman -S --noconfirm ${pacman[@]}
yay -S ${yay[@]}

sudo pacman -Rns grml-zsh-config

# DotFiles
git clone --recursive https://github.com/Stefanomarton/DotFiles.git && cd DotFiles && stow .

# Fonts configuration
sudo cp -r ~/Media/Fonts/JetBrainsMono/ /usr/share/fonts/

# Settings zsh as default shell
chsh -s /bin/zsh stefanomarton

# Install zpico
curl -sL --create-dirs https://gitlab.com/thornjad/zpico/-/raw/main/zpico.zsh -o $HOME/.local/lib/zpico/zpico.zsh

# Git Credential
gh auth login
gh auth git-credential
