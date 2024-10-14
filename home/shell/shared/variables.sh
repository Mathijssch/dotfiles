export VISUAL=nvim
export EDITOR="$VISUAL"

ttpath="$DOTFILES/timetagger.env"
if [ -f $ttpath ]; then
    source $ttpath
fi
