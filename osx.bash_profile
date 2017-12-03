[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.env_profile" ]] && source "$HOME/.env_profile" # Load private environment variables

export PATH="$HOME/.yarn/bin:$PATH"
