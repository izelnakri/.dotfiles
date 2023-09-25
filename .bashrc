#
# ~/.bashrc
#

# If not running interactively, don't do anything
echo "RUNNING .bashrc"
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'


complete -C /usr/bin/vault vault
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

. "$HOME/.cargo/env"
