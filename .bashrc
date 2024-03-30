# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export PATH=$PATH:/home/mathijs/.scripts/evince_synctex3
export PATH=$PATH:/home/mathijs/side-projects/oxidian/target/release

alias gnome-terminal=kitty
alias vimconfig="nvim ~/.config/nvim"
alias bashconfig="nvim ~/.bashrc"
alias vim="nvim"

#export NOTES_DIR=~/Work/Obsidian-notes/Notebook
export NOTES_DIR=~/Work/notebook/notes
export NOTES_OUTDIR="${NOTES_DIR}_out"

function notes {
    cd $NOTES_DIR; nvim . 
}

function notes_old {
    cd ~/obs-notes/Notebook; nvim .
}
#alias notes="cd $NOTES_DIR; nvim ."

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Better autocomplete
if [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
fi

## Set up some fzf tricks 
# Search over all files 

# alias fzfall="cd $(find ~/Work/Research/* -type d | fzf)"
source ~/.scripts/quickfind.sh # Defines some search functions

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# alias for easy ssh'ing
alias lupor="ssh -J mschuurm@ssh.esat.kuleuven.be mschuurm@lupor"
alias sista-nc-2="ssh -J mschuurm@ssh.esat.kuleuven.be mschuurm@sista-nc-2"
alias push_notes="ssh lupor \"ssh-agent bash -c 'ssh-add /users/sista/mschuurm/.ssh/id_rsa_autogit; cd obsidian-notes; git pull; obs_build generate -m --force; ./move_web_output'\""

# zotero sync script
alias zotsync="/home/mathijs/side-projects/zotero-sync/zotsync"

# Add custom scripts to path 
export PATH="$PATH:/home/mathijs/.scripts/"
export PATH="/home/mathijs/.local/bin:$PATH"

# Add Go installation 
export PATH=$PATH:/usr/local/go/bin


# eval $(keychain --eval id_rsa)
# eval $(keychain --eval id_rsa_ESAT)

## CUSTOMIZE THE BASH SHELL
## 

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Check if there are uncommitted changes, and color the git branch accordingly.
DIM_GREEN="\[\e[2;32m\]"
DIM_BROWN="\[\e[2;33m\]"
RST="\[\e[0m\]"
B_GREEN="\[\e[1;32m\]"
B_CYAN="\[\e[1;34m\]"


get_git_color(){
local gitstatus=$(git status --porcelain 2>/dev/null)
if [ -z "$gitstatus" ]; then
  # Working directory clean
  echo 32  # Color code for Green
else
  # Uncommitted changes
  echo 33  # Color code for Brown
fi
}


export PS1="${B_GREEN}\u${RST}|${B_CYAN}\w${RST}\[\e[2;\$(get_git_color)m\]\$(parse_git_branch)${RST}$ "
# Commands
#\e[ - Start color change
#1;32m - color code with <typeface>;<color>m
#\e[0m - Exit color mode change


# typefaces
# 0 - normal
# 1 - Bold (bright)
# 2 - Dim
# 3 - Underlined

# Colors
# 30 - Black
# 31 - Red
# 32 - Green
# 33 - Brown
# 34 - Blue
# 35 - Purple
# 36 - Cyan
# 37 - Light gray

# BASH AUTOCOMPLETE 

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# Disable the pgdn key
xmodmap -e "keycode 104="
xmodmap -e "keycode 109="

. "$HOME/.cargo/env"


source /home/mathijs/.bash_completions/tedo.sh

# Set the title of the terminal
PROMPT_COMMAND='echo -ne "\033]0;$(basename "${PWD}")\007"'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ------------------------------------------------
qtikz() {
    nvim ~/obs-notes/tikz/$1.tex
}

export VISUAL=nvim
export EDITOR="$VISUAL"
export TERM="xterm-kitty"

eval "$(zoxide init bash)"

alias cd=z
alias oxidian="~/side-projects/oxidian/target/release/main"

function sketchwatch {
    cd "~/utilities/sketchwatch"
    . actie 
    python autocopy.py -i ~/Dropbox/Sketches -o $NOTES_DIR/Attachments
}

function servenotes {
  export RUST_LOG=info
  oxidian watch $NOTES_DIR & oxidian_pid=$!
  live-server $NOTES_OUTDIR #& server_pid=$!

  kill $oxidian_pid
  #kill $server_pid
}

GPT_KEY_FILE=~/.gpt
if [ -f "$GPT_KEY_FILE" ]; then 
    export OPENAI_API_KEY=$(cat "$GPT_KEY_FILE")
else 
    echo "No gpt found"
fi
