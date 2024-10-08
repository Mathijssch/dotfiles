# Better autocomplete
if [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
fi

TEDO=~/.bash_completions/tedo.sh
if [ -f $TEDO ]; then
    source $TEDO
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

