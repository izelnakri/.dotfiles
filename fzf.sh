# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/sbin/fzf* ]]; then
  export PATH="$PATH:/usr/sbin/fzf"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/share/fzf/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/share/fzf/key-bindings.zsh"

