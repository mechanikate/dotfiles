<h1 align="center">mechanikate/dotfiles</h1>
<img src="https://github.com/mechanikate/dotfiles/blob/main/example.png?raw=true" alt="Example photo" /><img src="https://github.com/mechanikate/dotfiles/blob/main/example-installscript.png?raw=true" alt="Example photo" />
<hr />

Welcome to my dotfiles repo!

## Table of Contents
- [Installation](#installation)
  * [Requirements](#requirements)
  * [Using install script](#using-install-script)

## Installation 
Installation is pretty simple.
### Requirements
 * `git` to clone the repository
 * `ssh` to enable git `ssh`-ing below

### Using install script
Run the following in a terminal to get everything ready:
```bash
git clone git@github.com:mechanikate/dotfiles.git
cd dotfiles
chmod +x installscript.sh
```
And, if you don't have all of the added packages (e.g. [`neovim`](https://archlinux.org/packages/?name=neovim), [`polybar`](https://archlinux.org/packages/?name=polybar), [`i3-wm`](https://archlinux.org/packages/?name=i3-wm)) installed:
```bash
./installscript.sh -i y
```
Or, if you *do* have the packages installed:
```bash
./installscript.sh
```
The only time the install script *should* request sudo is when it's installing packages via `pacman` when asked to using the parameter `-i yes`.
There is also a basic usage/help message by using `./installscript.sh -h`.

