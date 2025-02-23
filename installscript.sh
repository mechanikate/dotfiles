#!/bin/bash
PBG='\033[45m'
RST='\033[0m'
usage() { echo "Usage: $0 [-i <yes|no>]" 1>&2; exit 1; }

while getopts "hi:" o; do
    case $o in
        i)
            i=${OPTARG}
	    [[ "$i" =~ ([Yy]([Ee][Ss])?)|([Nn]([Oo])?) ]] || usage
            ;;
       	h) 
	    usage
	    ;;
    	*)
	    i="N"
            ;;
    esac
done

shift $((OPTIND-1))

if ! which cava ; then  # check for cava
	echo -e "$PBG Uh oh! You don't have cava installed. Use an AUR package manager for https://github.com/karlstav/cava , or build it from source. $RST"
	echo -e "$PBG Press enter to continue anyways. $RST"
	read -p ""
fi

if [[ "$i" =~ [Yy]([Ee][Ss])? ]]; then
	echo -e "$PBG We will install the necessary packages (since -i is $i). $RST"
	sudo pacman -S stow i3-wm feh polybar neovim zsh grep sudo hyfetch git
fi

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || echo -e "$PBG git failed to clone the zsh-autosuggestions repository to ~/.oh-my-zsh/custom. To proceed, press Enter. To cancel, Ctrl+C! $RST" && read -p "" 

echo -e "$PBG Let's move this over to ~/.config/ ...$RST"
echo -e "$PBG Copying some files to their respective places ...$RST"
stow wallpaper || ( echo -e "$PBG stow-ing wallpaper failed. To proceed, press Enter. To cancel, Ctrl+C! $RST" && read -p "" ) 
stow desktop || ( echo -e "$PBG stow-ing desktop failed. To proceed, press Enter. To cancel, Ctrl+C! $RST" && read -p "" )
echo -e "$PBG Installing oh-my-zsh ...$RST"
sh -c "$(curl -fsSL https://install.ohmyz.sh/)"
stow terminal || ( echo -e "$PBG stow-ing terminal failed. To proceed, press Enter. To cancel, Ctrl+C! $RST" && read -p "" )
echo -e "$PBG Alright, you should be all set up! Enjoy! $RST"

