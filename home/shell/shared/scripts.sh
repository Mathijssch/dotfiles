if [ -d "$DOTFILES/scripts" ]; then
    # alias fzfall="cd $(find ~/Work/Research/* -type d | fzf)"
    source "$DOTFILES/scripts/quickfind.sh" # Defines some search functions

fi

if [ -d "~/side-projects/zotero-sync/zotsync" ]; then
    # zotero sync script
    alias zotsync="~/side-projects/zotero-sync/zotsync"
fi
