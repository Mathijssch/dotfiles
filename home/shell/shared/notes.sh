#export NOTES_DIR=~/Work/notebook/notes
#export NOTES_OUTDIR="${NOTES_DIR}_out"
#export NOTES_DIR_GET=~/Work/Research/GET/GET-notes/notes
#export NOTES_DIR_FWO=~/Work/Proposals/FWO/fwo-postdoc/notes
#DEFAULT_NOTES="$NOTES"
#TARGET_DIR="$NOTES"

#function map_dir() {
#    if [ "$1" = "get" ]; then
#        TARGET_DIR=$NOTES_DIR_GET
#    elif [ "$1" = "fwo" ]; then
#        TARGET_DIR=$NOTES_DIR_FWO
#    elif [ "$1" = "old" ]; then 
#        TARGET_DIR=$NOTES_DIR_GET

#    else; 
#        TARGET_DIR=$NOTES_DIR
#    fi
#}

#function open_notes() {
#    cd $1; nvim .
#}

#function notes_get {
#    open_notes $NOTES_DIR_GET
#}

#function notes {
#    #local TARGET_DIR="${1:-$DEFAULT_NOTES}"
#    local TARGET_DIR=$(map_dir $1)
#    echo $TARGET_DIR
#    open_notes $TARGET_DIR
#}

#function notes_old {
#    open_notes ~/obs-notes/Notebook
#}

#function sketchwatch() {
#    cd "$HOME/utilities/sketchwatch"
#    . actie 
#    output=map_dir "$1"
#    python autocopy.py -i ~/Dropbox/Sketches -o $output/Attachments
#}

#function servenotes {
#  export RUST_LOG=info
#  oxidian watch $NOTES_DIR & oxidian_pid=$!
#  live-server $NOTES_OUTDIR #& server_pid=$!

#  kill $oxidian_pid
#}

#function servenotes_get() {
#  export RUST_LOG=info
#  oxidian watch $1 $NOTES_DIR_GET & oxidian_pid=$! # Do full updates, it's just a small notebook
#  live-server "${NOTES_DIR_GET}_out" #& server_pid=$!

#  kill $oxidian_pid
#}
