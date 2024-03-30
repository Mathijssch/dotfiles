# Add custom scripts to path 
export PATH="$PATH:/home/mathijs/.scripts/"

# Add local installations
export PATH="/home/mathijs/.local/bin:$PATH"

# Add Go installation 
export PATH=$PATH:/usr/local/go/bin



export PATH=$PATH:/home/mathijs/.scripts/evince_synctex3
export PATH=$PATH:/home/mathijs/side-projects/oxidian/target/release


#export NOTES_DIR=~/Work/Obsidian-notes/Notebook
export NOTES_DIR=~/Work/notebook/notes
export NOTES_OUTDIR="${NOTES_DIR}_out"


. "$HOME/.cargo/env"


source /home/mathijs/.bash_completions/tedo.sh
