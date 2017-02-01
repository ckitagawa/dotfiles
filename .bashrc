#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

BROWSER=chromium

# Haskell support (out of date)
#export PATH=~/Library/Haskell/bin:$PATH

# Git Completion
source /usr/share/git/completion/git-completion.bash
source /usr/share/git/completion/git-prompt.sh

# Matlab ncurses requirement
export LD_LIBRARY_PATH=Downloads/ncurses/usr/lib/

# Aliases
#alias ls='ls --color=auto'
alias df="df -h"
alias pacman="sudo pacman"
alias pd="pwd"

# Improved listing
alias ll="ls -lhA"
alias ls="ls -C --color=auto"

# Navigation
alias cd..="cd .."
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Disk usage
alias du="du -ach | sort -h"

# Grep in style
alias grep="grep --color=auto"

# Process support
alias ps="ps auxf"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

# Bash edits
alias brc="gvim ~/.bashrc"
alias sbrc="source ~/.bashrc"

# Vim (force gvim)
alias v="gvim"
alias vi="gvim"

# Sublime text
alias subl="subl3"
alias sublime="subl3"

# ASCII table
alias ascii="man ascii"

# Prompt
TOLASTLINE=$(tput cup "$LINES")
PS1='[\u@\h] \w$(__git_ps1 " (%s)")\n\$ '
PS1="\[$TOLASTLINE\]$PS1"

# Fuck support
eval $(thefuck --alias)

# PATH additions
export PATH=~/Documents/Pebble/PebbleSDK-3.4/bin:$PATH
export TESSDATA_PREFIX=/usr/share/
export PATH=~/Documents/GitHub/matasanoC/libb64-1.2.1/base64:$PATH

# Functions
# Extract a file
extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1	;;
             *.tar.gz)    tar xvzf $1	;;
             *.bz2)       bunzip2 $1	;;
             *.rar)       rar x $1	;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1	;;
             *.tbz2)      tar xjf $1	;;
             *.tgz)       tar xzf $1	;;
             *.zip)       unzip $1	;;
             *.Z)         uncompress $1 ;;
             *.7z)        7z x $1	;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# pydir (host directory on $HOSTNAME:8000)
pydir() {
	URL="http://$HOSTNAME:8000";
	xdg-open $URL;
	python -m http.server;
}

# Find this file
what() {
	which $1 | xargs ls -la;
}

# Set color
export TERM=xterm-256color

# Fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
