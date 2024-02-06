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

# Prompt user for selection
echo "Select an option for environment:"
echo "1: Xorg"
echo "2: Wayland"
echo "3: Both"

read -p "Enter your choice (1/2/3): " choice

###############################
# Defining packages variables #
###############################

yay=()
pacman=()

programs_yay=(
		cava
		github-cli
		insync
		moar
		zaread-git
		ncspot
		spotify
		ticktick
		topgrade
		update-grub
		texlive-meta
		looking-glass-git
		ptsh
		wpgtk
)
programs_pacman=(
        yazi
        navi
		cargo
		neovim
        biber
		zsh
		zoxide
		obsidian
		kitty
		discord
		firefox
		code
		nemo
		bitwarden
		discord
		emacs-nativecomp
		fzf
		syncthing
		git-delta
		lazygit
		bat
		bluez
        blueman
		glow
		gparted
		gpick
		pipewire-alsa
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
		python-pip
		python-pyalsa
		python-typer
		ripgrep
		thunderbird
		npm
		redshift
		noto-fonts-emoji
		hugo
		networkmanager
		gnome-keyring
		linux-zen
		pandoc
		deja-dup
		feh
		flameshot
		hunspell-en_us
		hunspell-en_gb
		hunspell-en_it
		languagetool
		libre-office-fresh
		spice-vdagent
		texlive-meta
		virt-manager
		picom
		polkit-gnome
		qemu
        # Music and Video
		mpv
		cmus
        spotify-launcher
        # Archives
		unzip
        unrar
        # Language-Servers
        bash-language-server
		prettier
)

xorg_yay=(
        espanso
	    xbanish
)
xorg_pacman=(
	    xorg
	    xclip
	    lxappearance
)

wl_yay=(
        tofi
        # swww
        wlr-randr
        espanso-wayland
)
wl_pacman=(
        waybar
    	wl-clipboard
        slurp
        grim
)

cargo=(
		wallust
		)

if [ "$choice" -eq 1 ]; then
    yay=("${xorg_yay[*]}" "${programs_yay[*]}")
    pacman=("${xorg_pacman}[*]" "${programs_pacman[*]}")

elif [ "$choice" -eq 2 ]; then
    yay=("${wl_yay[*]}" "${programs_yay[*]}") 
    pacman=("${wl_pacman}[*]" "${programs_pacman[*]}")

elif [ "$choice" -eq 3 ]; then
    merged_yay=("${wl_yay[*]}" "${_wlpacman[*]}" "${programs_yay[*]}")
    merged_pacman=("${wl_pacman[*]}" "${xorg_pacman[*]}" "${programs_pacman[*]}")
    yay="${merged_yay}" 
    pacman="${merged_pacman}" 
else
    echo "Invalid choice. Please select a valid option."
    exit 1
fi

# Installin pacman packages
echo "Installing Pacman Packages"
for pac in "${pacman[@]}"; do
		echo "INSTALLING: ${pac}"
		sudo pacman -S "$pac" --noconfirm --needed
done

# Installin yay packages
echo "Installing Yay Packages"
for ya in "${yay[@]}"; do
		echo "INSTALLING: ${ya}"
		yay -S "$ya" --noconfirm --needed
done

# Installin cargo packages
echo "Installing Cargo Packages"
for i in "${cargo[@]}"; do
		echo "INSTALLING ${i} from cargo"
		cargo install "$i"
done

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
git clone --bare --recurse-submodules https://github.com/Stefanomarton/DotFiles.git .dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no 
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout -f

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

# Installing dmenu
echo "Installing Dmenu"
cd /home/$USER/.local/share/dmenu-flexipatch
make
sudo make install

# Git Credential
# gh auth login
