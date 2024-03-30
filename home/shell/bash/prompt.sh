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
