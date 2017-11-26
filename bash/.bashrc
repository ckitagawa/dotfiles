#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export LANG=en_US.UTF-8
export TERMINAL=urxvt

export BROWSER=chromium
export PYTHONPATH=.

# PATH additions
export PATH="~/Documents/Pebble/PebbleSDK-3.4/bin:$PATH"
export PATH="~/Documents/GitHub/matasanoC/libb64-1.2.1/base64:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="~/usr/local:$PATH"
export PATH="~/ckarch/bazel-bin:$PATH"
export PATH="/home/ckitagawa/.gem/ruby/2.4.0/bin:$PATH"
export GOPATH="$HOME/go"

# Haskell support (out of date)
#export PATH=~/Library/Haskell/bin:$PATH

# Git Completion
source /usr/share/git/completion/git-completion.bash
source /usr/share/git/completion/git-prompt.sh

# Matlab ncurses requirement
export LD_LIBRARY_PATH=Downloads/ncurses/usr/lib/

# Aliases
alias grep="rg"
alias sg="grep"

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
alias ms='cd $HOME/MidSun'
alias sch='cd $HOME/Documents/School/3B'

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

# Vim (force vim/gvim)
alias v="gvim"
alias vi="gvim"
alias vim="vim --servername VIM"
alias gvim="gvim --servername VIM"

# Sublime text
alias subl="subl3"
alias sublime="subl3"

# ASCII table
alias ascii="man ascii"

# Work Carryovers
alias g4d="cd"
alias blaze="bazel"
alias bb="bazel build"
alias br="bazel run"
alias bt="bazel test"

# Prompt
TOLASTLINE=$(tput cup 9999 0)
#PS1=$'[\u@\h] \w$(__git_ps1 " (%s)")\n\[\033[47m\]\[\033[30m\]\xee\x82\xb0\[\033[49m\]\[\033[37m\]\xe2\x96\x88\xe2\x96\x88\xe2\x96\x88\xee\x82\xb0 '
PS1=$'\u@\h \w$(__git_ps1 " (%s)")\n\[\033[7m\]\xee\x82\xb0   \[\033[27m\]\xee\x82\xb0 '
PS1="\[$TOLASTLINE\]$PS1"

# Base 16 Shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Fuck support
eval $(thefuck --alias)

# Functions
wgetall () {
  wget -r -nH -nd -np -R index.html* $1
}
# imake
imake () {
	python2 ~/imake/imake.py $@
}

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
if [ -e /usr/share/fzf/completion.bash ]; then
  source /usr/share/fzf/key-bindings.bash
  source /usr/share/fzf/completion.bash
fi

# Bazel
source /usr/local/lib/bazel/bin/bazel-complete.bash

# Bash History
PROMPT_COMMAND='history -a'
HISTTIMEFORMAT='%F %T '
HISTCONTROL=ignoreboth
HISTIGNORE='ls:bg:fg:history:clear'
HISTFILESIZE=1000000
HISTSIZE=1000000
shopt -s cmdhist
shopt -s histappend

