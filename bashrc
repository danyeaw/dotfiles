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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [[ "$OSTYPE" == "msys" ]]; then
    export GOROOT=/mingw64/lib/go
    export GOPATH=/home/dyeaw/go
    export PATH=$PATH:/c/tools/git/bin:/home/dyeaw/.local/bin:/c/users/dyeaw/.local/bin:$GOPATH/bin:/home/dyeaw/bin
    export PIP_REQUIRE_VIRTUALENV=true
fi

# bash-git-prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_THEME=Single_line_Ubuntu
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

# Add .local/bin to path
if [ -f "$HOME/.local/bin" ]; then
    export PATH="$PATH:$HOME/.local/bin"
fi

# Configure git credential manager core
export GCM_CREDENTIAL_STORE=secretservice

# Poetry
export PATH="$HOME/.poetry/bin:$PATH"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Pipx
export PIPX_DEFAULT_PYTHON=/home/dan/.pyenv/shims/python
