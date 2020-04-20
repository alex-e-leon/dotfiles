# Alex's personal dotfiles for OSX and linux

OSX dotfiles begin with `osx.` while linux dotfiles begin with `linux.`
Install the files by cloning this repository and symlinking to them in your home directory
Files are provided without the leading '.' to make listing and working with them easier.
Make sure that you add a dot when symlinking them

Files include:
- .vimrc
- .bash_prompt

## Linux only
- .bashrc

## OSX only
- .bash_profile
- .profile

## Terminal config
Current terminal font: [hack nerd fonts](https://github.com/ryanoasis/nerd-fonts)
Current terminal colorscheme: [IC_Orange_PPL](https://github.com/mbadolato/iTerm2-Color-Schemes)

### Other terminal colorschemes
- Afterglow
- Belafonte Night
- Birds of paradise
- Espresso
- Fidoloper
- Flatland
- Hybrid
- IC_Orange_PPL
- Medallion
- SeaShells
- Solarized Dark Dracula
- SpaceGray Eighties Dull
- SpaceDust
- Twilight

## OSX steps
OSX settings
adjust keyboard speed
switch capslock to escape

Install software
Ledger live
Iterm2
Chrome
Firefox
Steam
Spotify
Slack

install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
https://brew.sh/

install neovim
brew install neovim

install neovim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
https://github.com/junegunn/vim-plug

Install hack font
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

Import iterm profile
Symlink dotfiles

install ohmyzsh
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
https://ohmyz.sh/

Install antibody plugin manager
brew install getantibody/tap/antibody

