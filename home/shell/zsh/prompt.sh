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
  echo "green"  # Color code for Green
else
  # Uncommitted changes
  echo "red"  # Color code for Brown
fi
}


autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f %F{$(get_git_color)}${vcs_info_msg_0_}%f$ '
