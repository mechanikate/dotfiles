#!/bin/bash

# welcome to my install script for ease of use!
# note that all the echo -e and PBG/RST codes are for the purple background colouring and to reset that colouring
# thanks for reading!
# full repo @ https://github.com/mechanikate/dotfiles

PBG='\033[45m' # purple bg
RST='\033[0m' # reset color escapes
usage() { echo "Usage: $0 [-i <yes|no>] [-h]" 1>&2; exit 1; } # -h argument, followed by exit

while getopts "hi:" o; do # hi: because -h or -i can be used
    case $o in
        i) # -i <y/n/yes/no>
            i=${OPTARG}
	    [[ "$i" =~ ([Yy]([Ee][Ss])?)|([Nn]([Oo])?) ]] || usage # if the param is not yes/no/y/n, print out usage
            ;;
       	h) # -h
	    usage
	    ;;
    	*) # default to ./installscript.sh -i N
	    i="N" # do above, -i N
            ;;
    esac
done

shift $((OPTIND-1))

if [ ! -f ~/.installscriptdone ]; then
	echo -e "$PBG The install script might have already been run! Would you like to continue anyways? Press Enter if so. Otherwise, Ctrl+C! $RST"
	read -p ""
fi
if [[ "$i" =~ [Yy]([Ee][Ss])? ]]; then # bad regex shenanigans because I didn't want to figure out how to add flags (for case insensitivity) using just bash, equivalent to /y(es)?/i
	echo -e "$PBG We will install the necessary packages (since -i is $i). $RST"
	sudo pacman -S stow i3-wm feh polybar neovim zsh grep sudo hyfetch git base-devel ttf-0xproto-nerd pavucontrol  && ( echo -e "$PBG Installing packages done! To proceed to installing yay, type Enter. To avoid installing yay, type just the letter 'n' and enter. $RST") || ( echo -e "$PBG Installing packages failed. To proceed to installing yay, press Enter. To not install yay but proceed, type 'n' and press Enter. To cancel, press Ctrl+C! $RST") # this should be everything except cava
	read -p "" installyay
	echo $installyay
	if [[ -z "$installyay" ]] ; then
		echo -e "$PBG Installing yay... $RST"
		git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si || ( echo -e "$PBG Installing yay failed. To proceed, press Enter. To cancel, Ctrl+C! $RST" && read -p "" ) # install yay, see https://github.com/Jguer/yay
	fi
fi

if ! which cava ; then  # check for cava
	echo -e "$PBG Uh oh! You don't have cava installed. Do you want it to be installed for you? $RST"
	echo -e "$PBG Press enter to continue and install yay and cava. $RST"
	read -p "" # these will in general be used to give a sec for the user to either ctrl+c/quit or continue via enter
	yay -S cava # install cava from aur
fi
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || echo -e "$PBG git failed to clone the zsh-autosuggestions repository to ~/.oh-my-zsh/custom. To proceed, press Enter. To cancel, Ctrl+C! $RST" && read -p "" 

echo -e "$PBG Copying some files to their respective places ...$RST" # stow 
stow wallpaper || ( echo -e "$PBG stow-ing wallpaper failed. To proceed, press Enter. To cancel, Ctrl+C! $RST" && read -p "" ) # used for the wallpaper jpgs, by default sylveon.jpg
stow desktop || ( echo -e "$PBG stow-ing desktop failed. To proceed, press Enter. To cancel, Ctrl+C! $RST" && read -p "" ) # polybar, i3, pavucontrol, picom, custom auto-open font
echo -e "$PBG Installing oh-my-zsh ...$RST"
sh -c "$(curl -fsSL https://install.ohmyz.sh/)" # what it says on the tin, see line above
stow terminal || ( echo -e "$PBG stow-ing terminal failed. To proceed, press Enter. To cancel, Ctrl+C! $RST" && read -p "" ) # sylvfetch, hyfetch, konsole, nvim, zsh/oh-my-zsh
echo -e "$PBG Alright, you should be all set up! Enjoy! $RST" # all done!
touch ~/.installscriptdone

