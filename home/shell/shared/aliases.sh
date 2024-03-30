alias gnome-terminal=kitty
alias vimconfig="nvim ~/.config/nvim"
alias bashconfig="nvim ~/.bashrc"
alias vim="nvim"



# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# alias for easy ssh'ing
alias lupor="ssh -J mschuurm@ssh.esat.kuleuven.be mschuurm@lupor"
alias sista-nc-2="ssh -J mschuurm@ssh.esat.kuleuven.be mschuurm@sista-nc-2"
alias push_notes="ssh lupor \"ssh-agent bash -c 'ssh-add /users/sista/mschuurm/.ssh/id_rsa_autogit; cd obsidian-notes; git pull; obs_build generate -m --force; ./move_web_output'\""


# zotero sync script
alias zotsync="~/side-projects/zotero-sync/zotsync"


