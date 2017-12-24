# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/danyeaw/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/danyeaw/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/danyeaw/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/danyeaw/.fzf/shell/key-bindings.bash"

