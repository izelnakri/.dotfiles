[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:$HOME/.scripts
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="chromium"
export GDK_SCALE=2

if [[ "$(tty)" = "/dev/tty1" ]]; then
	startx
fi

export VOLTA_HOME="$HOME/.volta"
[ -s "$VOLTA_HOME/load.sh" ] && . "$VOLTA_HOME/load.sh"

export PATH="$VOLTA_HOME/bin:/root/.cargo/bin:$PATH"

zsh
