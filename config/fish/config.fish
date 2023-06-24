if status is-interactive
    # Commands to run in interactive sessions can go here
end
status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/dan/google-cloud-sdk/path.fish.inc' ]; . '/home/dan/google-cloud-sdk/path.fish.inc'; end
# rbenv
status --is-interactive; and ~/.rbenv/bin/rbenv init - fish | source
