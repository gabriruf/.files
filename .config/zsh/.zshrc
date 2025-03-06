#####################################################################
###            RUFF'S CONFIGURATION FOR THE Z-SHELL               ###
#####################################################################
###   Based of Luke Smith's and BreadOnPenguins' configurations   ###
#####################################################################



#############################
### ENVIRONMENT VARIABLES ###
#############################
export PATH="$PATH":~/.local/bin
export TERM="alacritty"
export BROWSER="firefox"
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CACHE_HOME="$HOME"/.cache
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export MANPAGER="less"
export WALS="$HOME/Pictures/Wallpapers"



######################################
### PROMPT AND SHELL CONFIGURATION ###
######################################
#PS1='%F{7}%n%F{7}%F{1}@%F{1}%F{7}%m%F{7} %F{1}%~%F{1} %F{1}$%F{1} %F{reset_color}%F{reset_color}' # old colorscheme and style
PS1='%F{#78C0E0}[%F{#78C0E0}%F{#F6C871}%n%F{#F6C871}%F{#E5D4ED}@%F{#E5D4ED}%F{#FF8700}%m%F{#FF8700}%F{#78C0E0}]%F{#78C0E0} %F{#005499}%~%F{#005499} %F{#FFDF5F}$%F{#FFDF5F} %F{reset_color}%F{reset_color}'

source $HOME/.config/zsh/zshgit # Git Prompt

zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors
autoload -U tetriscurses # zsh tetris, type in terminal "tetriscurses" to play

# Completion settings
zstyle ':completion:*' menu select # tab opens cmp menu
zstyle ':completion:*' complete-options true
zstyle ':completion:*' squeeze-slashes true 

# Options
setopt no_case_glob no_case_match # make cmp case insensitive
setopt append_history inc_append_history share_history # better history, on exit, history appends rather than overwrites; history is appended as soon as cmds executed; history shared across sessions
setopt auto_menu menu_complete # autocmp first menu match
setopt autocd # type a dir to cd
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt no_case_glob no_case_match # make cmp case insensitive
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
stty stop undef # disable accidental ctrl s

HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/history" 
HISTCONTROL=ignoreboth # consecutive duplicates & commands starting with space are not saved

bindkey -v # Vi Mode
export KEYTIMEOUT=100

# Loads syntax highlighting plugin if found, otherwise throw errors to /dev/null
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null



###############
### Aliases ###
###############
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias wget="wget --hsts-file="$XDG_CACHE_HOME/wget-hsts""
alias irssi="irssi --config="$XDG_CONFIG_HOME"/irssi/config --home="$XDG_DATA_HOME"/irssi"
# Gentoo Aliases
alias unstable="sudo vi /etc/portage/package.accept_keywords"
alias usestuff="sudo vi /etc/portage/package.use"
alias update="sudo emerge --update --newuse --deep @world"
