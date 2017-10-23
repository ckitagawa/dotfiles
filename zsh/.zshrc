# ~/.zshrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Language
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Support bash completions
autoload bashcompinit
bashcompinit

# Programs
export TERMINAL=urxvt
export BROWSER=chromium
export VISUAL=vim
export EDITOR=vim
bindkey -v

# Paths
export PATH="~/Documents/Pebble/PebbleSDK-3.4/bin:$PATH"
export PATH="~/Documents/GitHub/matasanoC/libb64-1.2.1/base64:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="~/usr/local:$PATH"
export PATH="~/ckarch/bazel-bin:$PATH"
export PATH="/home/ckitagawa/.gem/ruby/2.4.0/bin:$PATH"
export PYTHONPATH=.
export GOPATH="$HOME/go"

# Haskell support (out of date)
#export PATH=~/Library/Haskell/bin:$PATH

# Matlab ncurses requirement
export LD_LIBRARY_PATH=Downloads/ncurses/usr/lib/

# Git Completion (I manage this on my own through the AUR package)
#source /usr/share/git/completion/git-completion.zsh
source /usr/share/git/completion/git-prompt.sh
setopt prompt_subst
. /usr/share/git/completion/git-prompt.sh

# oh-my-zsh is managed through AUR so don't update this way.
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"

# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh/

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# oh-my-zsh plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

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
alias v="vim"
alias vi="vim"
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
PROMPT=$'%n@%m %~ $(__git_ps1 "(%s)")\n%S\xee\x82\xb0   %s\xee\x82\xb0 '
PROMPT="$TOLASTLINE$PROMPT"

# Base 16 Shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PROMPT" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

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
if [ -e /usr/share/fzf/completion.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# fzf + ag configuration
if _has fzf && _has ag; then
  export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
  export FZF_CTRL_R_COMMAND="$FZF_DEFAULT_COMMAND"
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
# setopt -s cmdhist
setopt APPEND_HISTORY

# Scrollup hist
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

