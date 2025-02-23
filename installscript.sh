#!/bin/bash
PBG='\033[45m'
RST='\033[0m'
if [[ "$(which cava)" =~ "not found" ]]; then 
	echo -e "$PBG Uh oh! You don't have cava installed. Use an AUR package manager for https://github.com/karlstav/cava , or build it from source. $RST"
	exit 1
fi

echo -e "$PBG Installing packages ...$RST"
sudo pacman -S stow i3-wm feh polybar neovim zsh grep sudo hyfetch git
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo -e "$PBG Let's move this over to ~/.config/ ...$RST"
echo -e "$PBG Copying some files to their respective places ...$RST"
stow wallpaper
stow desktop
echo -e "$PBG Installing oh-my-zsh ...$RST"
sh -c "$(curl -fsSL https://install.ohmyz.sh/)"
stow terminal
echo -e "$PBG Alright, you should be all set up! Enjoy! $RST"

