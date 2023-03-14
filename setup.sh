#!/bin/bash
# git clone https://raw.github.com/Stefanomarton/SMABS.git

echo 'Updating Applications'
sudo pacman -Syu

echo 'Cleaning caches and directories'
sudo pacman -Sc

echo 'Installing yay'
# Yay Installing
sudo pacman -S git base-devel
git clone https://aur.archlinux.org/yay.git
sudo chown -R $USER:$USER yay
cd yay
makepkg -si
cd
echo 'Installed yay'

# Installing Packages

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
		networkmanager
		awesome
		gnome-keyring
		linux-zen
)

for pac in "${pacman[@]}"; do
		echo "INSTALLING: ${pac}"
		sudo pacman -S "$pac" --noconfirm --needed
done

yay=(
		ptsh
		xbanish
		cava
		insync
		ferdium_bin
		swww
		espanso
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
		update-grub
)

for ya in "${yay[@]}"; do
		echo "INSTALLING: ${ya}"
		yay -S "$ya" --noconfirm --needed
done

# Check if grml is installed and removed it
if pacman -Qs grml-zsh-config > /dev/null ; then
		sudo pacman -Rns grml-zsh-config
else
	echo "The grml is not installed"
fi

# Enable grub os prober
echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a /etc/default/grub 
sudo update-grub

# DotFiles
git clone --bare --recurse-submodules https://github.com/Stefanomarton/DotFiles.git .dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no 
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout -f

# Fonts configuration
sudo cp -r ~/.local/share/Fonts/JetBrainsMono /usr/share/fonts

# Settings zsh as default shell
sudo chsh -s /bin/zsh $USER

# Install zpico
curl -sL --create-dirs https://gitlab.com/thornjad/zpico/-/raw/main/zpico.zsh -o $HOME/.local/lib/zpico/zpico.zsh

# Copy zshenv
sudo cp -r ~/SMABS/Files/zshenv /etc/zsh

# Git Credential
# gh auth login
