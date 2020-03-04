for file in ~/.{bash_prompt,alias,}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true
# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
syspip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

# set where virtual environments will live
export WORKON_HOME=$HOME/.virtualenvs
# ensure all new environments are isolated from the site-packages directory
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
# set python version for virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON='/usr/bin/python'
# use the same directory for virtualenvs as virtualenvwrapper
export PIP_VIRTUALENV_BASE=$WORKON_HOME
# makes pip detect an active virtualenv and install to it
export PIP_RESPECT_VIRTUALENV=true
if [[ -r /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
else
    echo "WARNING: Can't find virtualenvwrapper.sh"
fi

# Ensure user-installed binaries take precedence
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

#Bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#Setup yarn executable
export PATH="$PATH:`yarn global bin`"

#Setup ls color for OSX
export CLICOLOR=1

#Setup grep color
export GREP_OPTIONS='--color=auto'

#Setup adb command
if [ -d "/Users/alex.leon/Library/Android/sdk/platform-tools" ] ; then
  export PATH="/Users/alex.leon/Library/Android/sdk/platform-tools:$PATH"
fi

#Make sure that locale is set properly
export LC_ALL=en_AU.UTF-8
