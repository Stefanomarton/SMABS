#!/bin/bash
# git clone https://raw.github.com/Stefanomarton/SMABS.git

echo 'Updating Applications'
sudo pacman -Syu

echo 'Cleaning caches and directories'
sudo pacman -Sc

echo 'Installing paru'

sudo pacman -S git base-devel
git clone https://aur.archlinux.org/paru.git
sudo chown -R $USER:$USER paru
cd paru
makepkg -si
cd
echo 'Installed paru'

###############################
# Defining packages variables #
###############################

# check cpu
vendor=$(lscpu | awk '/Vendor ID/{print $3}')
if [[ "$vendor" == "GenuineIntel" ]]; then
    cpu='intel-ucode'
elif [[ "$vendor" == "AuthenticAMD" ]]; then
    cpu='amd-ucode'
fi

programs=(
hyprland
xdg-desktop-porta-hyprland
jq
cava
buku
peek
$cpu
inkscape
ollama
dragon-drop
xournalpp
aylurs-gtk-shell
github-cli
insync
moar
zaread-git
ncspot
spotify
ticktick
topgrade
update-grub
pipewire
wireplumber
texlive-meta
looking-glass-rc
molsketch
ptsh
wpgtk
stow
rocm-smi-lib
atool
perl-image-exiftool
words
yazi
navi
cargo
neovim
biber
zsh
zoxide
zotero
obsidian
kitty
discord
floorp-bin
nemo
bitwarden
discord
emacs-wayland
fzf
syncthing
cliphist
imv
git-delta
lazygit
bat
bluez
blueman
glow
gparted
gpick
fd
libqalculate
pipewire-alsa
eww-git
libreoffice-fresh
pipewire-pulse
rofi
qmk
zathura
zathura-pdf-mupdf
sxiv
btop
darktable
pavucontrol
python-pillow
pyprland-git
cmake
dialog
dropbox
dunst
rust
rust-analyzer
btrfs-progs
python-pip
python-pyalsa
python-typer
ripgrep
rsync
ripgrep-all
thunderbird
npm
redshift
noto-fonts-emoji
hugo
networkmanager
gnome-keyring
linux-zen
enchant
pandoc-cli
deja-dup
feh
hunspell-en_us
nano
nmap
hunspell-it
languagetool
libre-office-fresh
spice-vdagent
texlive-meta
virt-manager
picom
polkit-gnome
qemu-base
qemu-desktop
# Music and Video
mpv
cmus
spotify-launcher
# Archives
unzip
zip
unrar
# Language-Servers
bash-language-server
prettier
tofi-git
swww
wlr-randr
espanso-wayland-git
socat
wl-clipboard
slurp
nuspell
nvtop
opentabletdriver
steam
grim
wallust-git
wireless_tools

python-matplotlib
python-numpy
python-pandas
python-pywlroots
python-rich

hspell
spell
aspell-en
aspell-it

base-devel

alsa-utils
)

# enable emacs service
systemctl --user enable emacs

# Check if grml is installed and removed it
echo "Check if grml is installed and removed it"
if pacman -Qs grml-zsh-config > /dev/null ; then
		sudo pacman -Rns grml-zsh-config
else
	echo "The grml is not installed"
fi

# Remove pulseaudio if present with all related programs
echo "Remove pulseaudio if present with all related programs"
if pacman -Qs pulseaudio > /dev/null ; then
		sudo pacman -Rc pulseaudio
else
	echo "Pulse Audio is not installed"
fi

# Enable grub os prober
echo "Enabling grub os prober and updating GRUB" 
echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a /etc/default/grub 
sudo update-grub

# DotFiles
echo "Installing DotFiles"
git clone --recurse-submodules https://github.com/Stefanomarton/DotFiles.git ~/.dotfiles/
stow ~/.dotfiles/ 

# Fonts configuration
echo "Configuring Fonts"
sudo cp -r ~/.local/share/Fonts/JetBrainsMono /usr/share/fonts

# Settings zsh as default shell
echo "Settings zsh as default shell"
sudo chsh -s /bin/zsh $USER

# Install zpico
echo "Installing zpico"
curl -sL --create-dirs https://gitlab.com/thornjad/zpico/-/raw/main/zpico.zsh -o $HOME/.local/lib/zpico/zpico.zsh

# Copy zshenv
echo "Copyng zshenv for proper login config"
sudo cp -r ~/SMABS/Files/zshenv /etc/zsh

# Git Credential
# gh auth login
