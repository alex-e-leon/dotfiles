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

_Note this can be automated with a script (see osx defaults cli tool)
https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/_

- adjust keyboard speed
- switch capslock to escape
- turn off brightness auto adjust
- increase mouse speed + switch scrolling

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
\\ install basics + antidote zsh plugin manager, fzf, rg
brew install neovim mise antidote fzf ripgrep compdef
\\ install hack font
brew install --cask font-hack-nerd-font
\\ install node + npm (replace with latest)
mise use --global node@26 
\\ install livedown
npm i -g livedown
\\ isntall asimov to make time-machine work properly (optional)
brew install asimov 
```

### Fix nerdree-tabs
Update timer values on `.local/share/nvim/lazy/vim-nerdtree-tabs/nerdtree_plugin/`
to:
```
    call timer_start(1, {-> execute('q') })
    call timer_start(20, {-> execute('vertical resize 31') })
    call timer_start(25, {-> execute('wincmd w') })
```

### Finish
- Import iterm profile
- Symlink dotfiles
- Use .zshenv for local env variables/private keys
