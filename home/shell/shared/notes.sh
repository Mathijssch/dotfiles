export NOTES_DIR=~/Work/notebook/notes
export NOTES_OUTDIR="${NOTES_DIR}_out"
export NOTES_DIR_GET=~/Work/Research/GET/GET-notes/notes

function open_notes() {
    cd $1; nvim .
}

function notes_get {
    open_notes $NOTES_DIR_GET
}

function notes {
    open_notes $NOTES_DIR
}

function notes_old {
    open_notes ~/obs-notes/Notebook
}


function sketchwatch() {
    cd "~/utilities/sketchwatch"
    . actie 
    if [ $1 == "get" ]; then 
        output=$NOTES_DIR_GET
    else 
        output=$NOTES_DIR
    fi 
    python autocopy.py -i ~/Dropbox/Sketches -o $output/Attachments
}

function servenotes {
  export RUST_LOG=info
  oxidian watch $NOTES_DIR & oxidian_pid=$!
  live-server $NOTES_OUTDIR #& server_pid=$!

  kill $oxidian_pid
}

function servenotes_get {
  export RUST_LOG=info
  oxidian watch $NOTES_DIR_GET & oxidian_pid=$!
  live-server "${NOTES_DIR_GET}_out" #& server_pid=$!

  kill $oxidian_pid
}
