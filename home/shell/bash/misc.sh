# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

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

## Set up some fzf tricks 
# Search over all files 

# eval $(keychain --eval id_rsa)
# eval $(keychain --eval id_rsa_ESAT)

# Disable the pgdn key
xmodmap -e "keycode 104="
xmodmap -e "keycode 109="


# Set the title of the terminal
PROMPT_COMMAND='echo -ne "\033]0;$(basename "${PWD}")\007"'
# ------------------------------------------------

if [ -t 1 ]; then
	bind 'set show-all-if-ambiguous on'
	bind 'TAB:menu-complete'
fi
