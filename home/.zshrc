BASE_CONFIGS=$HOME/repos/dotfiles/home/shell
SHARED_CONFIGS=$BASE_CONFIGS/shared
CONFIGS=$BASE_CONFIGS/zsh

if [ -f $CONFIGS/init.sh ]; then
    source $CONFIGS/init.sh                                                                                  
fi

FILES_STR=$(find "$CONFIGS" -name '*.sh' -not -name 'init.sh')
FILES_SHARED_STR=$(find "$SHARED_CONFIGS" -name '*.sh' -not -name 'init.sh')

IFS=$'\n'       # Set the Internal Field Separator to newline
# Loop over files in SHARED_CONFIGS directory
for file_shared in ${(f)FILES_SHARED_STR}; do
    #echo "Processing shared file: $file_shared"
    source $file_shared
    # Add your processing logic here
done

# Loop over files in CONFIGS directory
for file in ${(f)FILES_STR}; do
    #echo "Processing file: $file"
    source $file
done

