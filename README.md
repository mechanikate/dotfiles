<h1 align="center">mechanikate/dotfiles</h1>
<img src="https://github.com/mechanikate/dotfiles/blob/main/example2.png?raw=true" alt="Example photo" />
<hr />

Welcome to my dotfiles repo!

## Installation 
Installation is pretty simple.
### Requirements
 * `git`
 * `ssh` to clone the repository

### Using install script
Run the following in a terminal:
```bash
git clone git@github.com:mechanikate/dotfiles.git
cd dotfiles
chmod +x installscript.sh
./installscript.sh
```
When prompted by sudo, type your root password in (only used to install necessary packages and moving configs to `/`) and hope that it works, because honestly it's kind of jank.
