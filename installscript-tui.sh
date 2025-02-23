yes_or_exit () {
	whiptail --yesno "$1" $2 $3
	[[ $? == 1 ]] && exit 0 || echo "Continuing..."
}
if [ -f ~/.installscriptdone ]; then
	yes_or_exit "The install script has already been ran! Continue?" 8 50
fi
echo -e "$PBG Installing packages... $RST"
sudo pacman -S stow i3-wm feh polybar neovim zsh grep sudo hyfetch git base-devel ttf-0xproto-nerd pavucontrol && keyword="succeeded" || keyword="failed"
whiptail --yesno "Installing packages $keyword. Install yay for AUR packages/cava too?" 8 50
[[ $? == 0 ]] && ( echo -e "$PBG Installing yay... $RST" && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si || ( yes_or_exit "Installing yay failed! Proceed anyways?" 8 50 ) ) # install yay, see https://github.com/Jguer/yay
if ! which cava ; then
	echo -e "$PBG Installing yay... $RST"
	yay -S cava
fi
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || yes_or_exit "git failed to clone the zsh-autosuggestions repository to ~/.oh-my-zsh, usually because it already exists. Continue anyways?" 12 50
( stow wallpaper && stow desktop ) || yes_or_exit "Stowing wallpaper or desktop failed. Continue anyways?" 8 50
sh -c "$(curl -fsSL https://install.ohmyz.sh/)"
stow terminal && keyword="succeeded" || keyword="failed"
whiptail --msgbox "Stowing terminal $keyword. Regardless, we're all done!" 8 50

