base00=default   # - Default
base01='#151515' # - Lighter Background (Used for status bars)
base02='#202020' # - Selection Background base03='#303030' # - Comments, Invisibles, Line Highlighting
base03='#303030' # - Comments, Invisibles, Line Highlighting
base04='#505050' # - Dark Foreground (Used for status bars)
base05='#D0D0D0' # - Default Foreground, Caret, Delimiters, Operators
base06='#E0E0E0' # - Light Foreground (Not often used)
base07='#F5F5F5' # - Light Background (Not often used)
base08='#AC4142' # - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
base09='#D28445' # - Integers, Boolean, Constants, XML Attributes, Markup Link Url
base0A='#F4BF75' # - Classes, Markup Bold, Search Text Background
base0B='#90A959' # - Strings, Inherited Class, Markup Code, Diff
base0C='#75B5AA' # - Support, Regular Expressions, Escape Characters, Markup Quotes
base0D='#6A9FB5' # - Functions, Methods, Attribute IDs, Headings
base0E='#AA759F' # - Keywords, Storage, Selector, Markup Italic, Diff Changed
base0F='#8F5536' # - Deprecated, Opening/Closing Embedded Language Tags, e.g. <? php ?>

set -g status-left-length 32
set -g status-right-length 150
set -g status-interval 5

# default statusbar colors
set-option -g status-fg $base02
set-option -g status-bg $base00
# set-option -g status-attr default

set -g window-status-style fg=$base0F,bg=$base00
# set-window-option -g window-status-bg $base00
set -g window-status-format " #I #W"
# active window title colors
set -g window-status-current-style fg=$base0B,bg=$base00
# set-window-option -g window-status-current-fg $base0B
# set-window-option -g window-status-current-bg $base00
set-window-option -g  window-status-current-format " #I #[bold]#W "

# pane border colors
set -g pane-border-style fg=$base02
# set-window-option -g pane-border-fg $base02
set -g pane-active-border-style fg=colour22
# set-window-option -g pane-active-border-fg colour22

# message text
set -g message-style fg=$base0C,bg=$base00
# set-option -g message-bg $base00
# set-option -g message-fg $base0C

# pane number display
set-option -g display-panes-active-colour $base0C
set-option -g display-panes-colour $base01

# clock
set-window-option -g clock-mode-colour $base0A

tm_session_name="#[fg=$base0D,bg=$base00] #S "
set -g status-left "$tm_session_name"

# fish_battery="#(`which fish` -c 'battery ▮ ▯ true (set_color normal) (set_color normal) (set_color normal)')"
tm_battery="#[fg=$base0B,bg=$base00] #(~/.dotfiles/battery-indicator.sh)"
tm_date="#[fg=$base0F,bg=$base00] %a %d, %m.%y %R"
tm_host="#[fg=$base0D,bg=$base00] #h "
set -g status-right "$tm_battery $tm_date $tm_host"

