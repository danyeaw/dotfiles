[ -f /etc/bashrc ] && source /etc/bashrc
[ -f /etc/bash.bashrc ] && source /etc/bash.bashrc

# enable globbing like **/*.py
shopt -s globstar

# enable color support of ls and also add handy aliases
if [ -x "$(command -v dircolors)" ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Local customized path and environment settings, etc.
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
