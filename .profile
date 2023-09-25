[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:$HOME/.scripts
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"
export GDK_SCALE=2
export ELIXIR_ERL_OPTIONS="+fnu"

if [[ "$(tty)" = "/dev/tty1" ]]; then
  timedatectl set-ntp true
	startx
fi

zsh
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
. "$HOME/.cargo/env"
