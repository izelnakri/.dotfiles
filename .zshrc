# NOTE: make fzf like suggestions
# NOTE: make ^F complete the suggestion
# lsof -i:8080 -r 2 # repeat every 2 seconds
if [ -z "$TMUX" ]; then
  tmux -u attach
fi

autoload -U colors && colors

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ ->\ \1/'
}

function display_jobs_count_if_needed {
  local job_count=$(jobs -s | wc -l | tr -d " ")

  if [ $job_count -gt 0 ]; then
    echo "%B%{$fg[yellow]%}|%j| ";
  fi
}

unsetopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
setopt PROMPT_SUBST
setopt SHARE_HISTORY # Share history between all sessions.

PROMPT='%{$fg[blue]%}$(date +%H:%M:%S) $(display_jobs_count_if_needed)%B%{$fg[green]%}%n %{$fg[blue]%}%~%{$fg[yellow]%}$(parse_git_branch) %{$reset_color%}'

LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
EDITOR="nvim"
BROWSER="brave"
HISTTIMEFORMAT="%d/%m/%y %T "
HISTFILE=~/.cache/zsh/history
HISTSIZE=10000000
SAVEHIST=10000000
POSTGRES_USER="postgres"
POSTGRES_PASSWORD="postgres"
POSTGRES_HOST="localhost"
POSTGRES_PORT=5432
PGUSER=$POSTGRES_USER
PGPASSWORD=$POSTGRES_PASSWORD
PGHOST=$POSTGRES_HOST
PGPORT=$POSTGRES_PORT
FZF_DEFAULT_COMMAND='fd --type f'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

alias onport="ps aux | grep"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias vim=nvim
alias vi=nvim
alias v=nvim
alias emacs="emacs -nw"
alias e="helix"
alias dockerremoveall="sudo docker system prune -a"
alias checkmostmodifiedfiles="git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -10"
alias server="mix phoenix.server"
alias terminate="lsof -ti:4200 | xargs kill"
alias k="kubectl"
alias d="sudo docker"
alias kube="kubectl"
alias lusd="node /home/izelnakri/cron-jobs/curve-lusd.js"
alias todo="nvim ~/Dropbox/TODO.md"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
# alias ls="lsd"
# alias ll="ls -lah"
# alias find="fd"
alias lf="lfub"
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"
alias weather="curl http://wttr.in/"
alias g="git"
alias x="npx"
alias bitbox-bridge="/opt/bitbox-bridge/bin/bitbox-bridge"
# FIND_AND_REPLACE fd . $folderName/. -exec sed 's/SEARCH_STR/REPLACE_STR/g' -i
alias housing="nvim ~/Dropbox/HOUSING.md"

function cheat {
  curl cheat.sh/$argv
}

# As in "delpod defualt"
# As in "delpod <namespace>"
function delpod {
  kubectl delete po --all -n $argv
}

# kill everything in a namespace
function fuck {
  kubectl delete all --all -n $argv
}

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

# Packages
source <(antibody init)
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-history-substring-search
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle robbyrussell/oh-my-zsh path:plugins/encode64
antibody bundle robbyrussell/oh-my-zsh path:plugins/git

# Bind up and down arrows to history substring search
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

bindkey '^N' history-search-forward
bindkey '^P' history-search-backward

bindkey -s '^o' '^ulfcd\n'

# fzf
[ -f ~/.dotfiles/fzf.zsh ] && source ~/.dotfiles/fzf.zsh

export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_file_bytes 1024000"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/vault vault

eval "$(rbenv init -)"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$PNPM_HOME:$PATH"

export PNPM_HOME="/home/izelnakri/.local/share/pnpm"
export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=🖼:\
*.webp=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.jpe=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.tif=🖼:\
*.tiff=🖼:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📚:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.m=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.wav=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.avi=🎥:\
*.mov=🎥:\
*.mpg=🎥:\
*.wmv=🎥:\
*.m4b=🎥:\
*.flv=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.gba=🎮:\
*.nes=🎮:\
*.gdi=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
*.jar=♨:\
*.java=♨:\
"

# bun completions
[ -s "/home/izelnakri/.bun/_bun" ] && source "/home/izelnakri/.bun/_bun"

# Bun
export BUN_INSTALL="/home/izelnakri/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(direnv hook zsh)"
