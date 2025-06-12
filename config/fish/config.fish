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


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/miniconda3/bin/conda
    eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
        . "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "$HOME/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

