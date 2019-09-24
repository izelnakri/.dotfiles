PATH="$HOME/.cargo/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.deno/bin:/usr/local/bin:/usr/sbin:$PATH" # TODO: add asdf

if [ -z "$TMUX" ]; then
  tmux -u attach
fi

autoload -U colors && colors

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ ->\ \1/'
}

setopt PROMPT_SUBST
PROMPT='%B%{$fg[green]%}%n %{$fg[blue]%}%~%{$fg[yellow]%}$(parse_git_branch) %{$reset_color%}'

LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
EDITOR="nvim"
HISTTIMEFORMAT="%d/%m/%y %T "
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
POSTGRES_USER="postgres"
POSTGRES_PASSWORD="postgres"
POSTGRES_HOST="localhost"
POSTGRES_PORT=5432
PGUSER=$POSTGRES_USER
PGPASSWORD=$POSTGRES_PASSWORD
PGHOST=$POSTGRES_HOST
PGPORT=$POSTGRES_PORT
FZF_DEFAULT_COMMAND='fd --type f'

alias onport="ps aux | grep"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias vim=nvim
alias vi=nvim
alias dockerremoveall="docker system prune -a"
alias checkrepo="git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -10"
alias server="mix phoenix.server"
alias terminate="lsof -ti:4200 | xargs kill"
alias k="kubectl"
alias kube="kubectl"

# As in "delpod defualt"
# As in "delpod <namespace>"
function delpod {
  kubectl delete po --all -n $argv
}

# kill everything in a namespace
function fuck {
  kubectl delete all --all -n $argv
}

# # bind  ^k history-search-forward
# # bind  ^j history-search-backward
# function fish_user_key_bindings
#     fish_vi_mode
#     bind -M insert \cf accept-autosuggestion
#     bind \cf accept-autosuggestion
#     for mode in insert default visual
#       bind -M $mode \cp 'up-or-search'
#       bind -M $mode \cn 'down-or-search'
#     end
# end

# wg-quick down man-quick
# wg-quick up man-quick

# if [ -f ~/.bash_aliases ]; then
#   . ~/.bash_aliases
# fi

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# set -g fish_user_paths "/usr/local/opt/postgresql@10/bin" $fish_user_paths
