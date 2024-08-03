#!/bin/bash
PBG='\033[45m'
RST='\033[0m'
if [[ "$(which cava)" =~ "not found" ]]; then 
	echo -e "$PBG Uh oh! You don't have cava installed. Use an AUR package manager for https://github.com/karlstav/cava , or build it from source. $RST"
	exit 1
fi

echo -e "$PBG Installing packages ...$RST"
sudo pacman -S cava i3-wm feh polybar neovim zsh grep sudo hyfetch git
echo -e "$PBG Let's move this over to ~/.config/ ...$RST"
cp -r . ~/.config/
cd ~/.config/
echo -e "$PBG Copying some files to their respective places ...$RST"
cp -r ~/.config/konsole/ ~/.local/share/
sudo cp -r ~/.config/to/ /
echo -e "$PBG Installing oh-my-zsh ...$RST"
sh -c "$(curl -fsSL https://install.ohmyz.sh/)"
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc
echo -e "$PBG Enabling the wallpaper script ...$RST"
systemctl --user enable run-u411.timer
systemctl --user enable run-u411.service
echo -e "$PBG Alright, you should be all set up! Enjoy! $RST"

