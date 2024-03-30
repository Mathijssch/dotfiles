if [ -d ~/.scripts ]; then
    # alias fzfall="cd $(find ~/Work/Research/* -type d | fzf)"
    source ~/.scripts/quickfind.sh # Defines some search functions

fi

if [ -d "~/side-projects/zotero-sync/zotsync" ]; then
    # zotero sync script
    alias zotsync="~/side-projects/zotero-sync/zotsync"
fi
