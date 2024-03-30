# eval `keychain --agents ssh --eval id_rsa`
# eval `keychain --agents ssh --eval id_rsa_ESAT`

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Check if there are uncommitted changes, and color the git branch accordingly. 
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


export PS1="\e[1;37m\u\e[0m|\e[34m\w\e[2;\$(get_git_color)m\$(parse_git_branch)\e[0m>"
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

. "$HOME/.cargo/env"
