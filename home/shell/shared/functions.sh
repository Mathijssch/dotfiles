
function notes {
    cd $NOTES_DIR; nvim . 
}

function notes_old {
    cd ~/obs-notes/Notebook; nvim .
}


function sketchwatch {
    cd "~/utilities/sketchwatch"
    . actie 
    python autocopy.py -i ~/Dropbox/Sketches -o $NOTES_DIR/Attachments
}

function servenotes {
  export RUST_LOG=info
  oxidian watch $NOTES_DIR & oxidian_pid=$!
  live-server $NOTES_OUTDIR #& server_pid=$!

  kill $oxidian_pid
  #kill $server_pid
}
