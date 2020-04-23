# Alex's personal dotfiles for OSX and linux

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
### OSX settings
- adjust keyboard speed
- switch capslock to escape

### Install software
- Iterm2
- Chrome
- Firefox
- Spotify
- Slack

### Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"  
https://brew.sh/

### Install packages
```
\\ neovim
brew install neovim
\\ antibody zsh plugin manager
brew install getantibody/tap/antibody
\\ hack font
brew tap homebrew/cask-fonts   
brew cask install font-hack-nerd-font
\\ install fzf
brew install fzf
\\ install rg
brew install ripgrep
\\ Install neovim plug
\\ https://github.com/junegunn/vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim  
\\ Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
```

### Finish
- Import iterm profile
- Symlink dotfiles
