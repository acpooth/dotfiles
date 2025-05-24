
# This code will be append to the fish config file:
# ~/.config/fish/config.fish


### Alias
alias c='bat --wrap never'
alias lspy='ls *.py'
alias emacs= '/home/acph/.config/emacs/bin/doom run'
alias doom='/home/acph/.config/emacs/bin/doom'

### Abbreviations
abbr -a gdf git diff
abbr -a gad git add
abbr -a gst git status
abbr -a gco git commit
abbr -a emac emacs -nw -q

### Variables
set -gx EDITOR emacs -nw -q
set -gx PAGER bat --wrap never 	# Only with arch based in debian bases the program is batcat


# alias tea='/home/acph/mybin/tea-0.9.2-linux-amd64'


# alias qq='/home/acph/repos/google-search-from-command-line/goocli.sh'
# alias cb='flatpak run app.getclipboard.Clipboard'

#########
# Atuin #
#########

#set -gx ATUIN_NOBIND "true"
#atuin init fish | source

# bind to ctrl-r in normal and insert mode, add any other bindings you want here too
#bind \cr _atuin_search
#bind -M insert \cr _atuin_search
