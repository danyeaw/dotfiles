# pyenv
if test -f ~/.pyenv/bin/pyenv
    pyenv init - fish | source
end

# The next line updates PATH for the Google Cloud SDK.
if test -f ~/google-cloud-sdk/path.fish.inc
    . '~/google-cloud-sdk/path.fish.inc'
end

# rbenv
if test -f ~/.rbenv/bin/rbenv
    status --is-interactive; and ~/.rbenv/bin/rbenv init - fish | source
end

# Hombrew
if test -f /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

set PATH $PATH ~/.local/bin

