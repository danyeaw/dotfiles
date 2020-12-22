## Get my PATH setup
source ~/.profile
## Get my Bash aliases
source ~/.bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
