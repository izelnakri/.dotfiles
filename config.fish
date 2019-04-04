set NOTION_HOME $HOME/.notion
set PATH /usr/local/bin /usr/sbin $HOME/.cargo/bin $HOME/.yarn/bin $HOME/.config/yarn/global/node_modules/.bin $HOME/.deno/bin $NOTION_HOME/bin $PATH
set EDITOR nvim

function parse_git_branch
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ ->\ \1/'
end

function prompt_pwd --description 'Print the current working directory, NOT shortened to fit the prompt'
    if test "$PWD" != "$HOME"
        printf "%s" (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
    else
        echo '~'
    end

end

# bind  ^k history-search-forward
# bind  ^j history-search-backward
function fish_user_key_bindings
    fish_vi_mode
    bind -M insert \cf accept-autosuggestion
    bind \cf accept-autosuggestion
    for mode in insert default visual
      bind -M $mode \cp 'up-or-search'
      bind -M $mode \cn 'down-or-search'
    end
end

function fish_mode_prompt
end

function fish_prompt
  printf '%s%s%s ' (set_color -o green) (whoami) (set_color -o cyan) (prompt_pwd) \
    (set_color -o yellow) (parse_git_branch)
end

function fish_greeting
end

set -U EDITOR 'vim'

alias onport="ps aux | grep"
alias server="mix phoenix.server"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

set HISTTIMEFORMAT "%d/%m/%y %T "

set POSTGRES_USER "postgres"
set POSTGRES_PASSWORD "postgres"
set POSTGRES_HOST "localhost"

alias checkrepo="git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -10"

set TF_VAR_scaleway_organization "f553408d-9333-4aaf-b1c3-e06fcca544be"
set TF_VAR_scaleway_token "b7f0ce29-fbb4-4851-aeeb-1f49483975d7"

alias terminate="lsof -ti:4200 | xargs kill"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/izelnakri/google-cloud-sdk/path.bash.inc' ]; then source '/Users/izelnakri/google-cloud-sdk/path.bash.inc'; end

# The next line enables shell command completion for gcloud.
if [ -f '/Users/izelnakri/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/izelnakri/google-cloud-sdk/completion.bash.inc'; end

alias dockerremoveall="docker system prune -a"
alias vim=nvim
alias vi=nvim

set PGUSER postgres
set PGPASSWORD postgres
set PGPORT 5432
set PGHOST localhost

# wg-quick down man-quick
# wg-quick up man-quick
# if [ -f ~/.bash_aliases ]; then
#   . ~/.bash_aliases
# fi

if [ -z "$TMUX" ]
    tmux -u attach
end

alias proxy-server="ember serve --proxy http://localhost:3000"
set -g fish_user_paths "/usr/local/opt/postgresql@10/bin" $fish_user_paths

set -gx NOTION_HOME "$HOME/.notion"
test -s "$NOTION_HOME/load.fish"; and source "$NOTION_HOME/load.fish"

