# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use python 3 instead of system python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# rbenv default config
eval "$(rbenv init - zsh)"

# Ensure user-installed binaries take precedence
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# Setup virtualenvwrapper - not working lately
# export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/Devel
# [ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

# User configuration

#Make sure that locale is set properly
export LC_ALL=en_AU.UTF-8

# SET ls colors
export CLICOLOR=1
export LSCOLORS="Fxfxdxdxcxegedabagacad"

#Setup grep color
export GREP_OPTIONS='--color=auto'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

#Setup FZF to use ripgrep instead of find so that it ignores gitignored files
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git/'"

# Load in .alias file
for file in ~/.{alias,}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/alex/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/alex/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/alex/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/alex/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# NVM default config - for some reason this must come last
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load antibody
source <(antibody init)

# Load antibody plugins
antibody bundle romkatv/powerlevel10k
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle lukechilds/zsh-better-npm-completion
# plugins to look at
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
# https://github.com/athityakumar/colorls
# https://github.com/zsh-users/zsh-syntax-highlighting
# + OhMyZsh plugins
# plugins=(git colored-man-pages frontend-search globalias safe-paste)
