# qf -- quick find.
#
# Small utility to quickly search through my files. 
# By default, it restricts to git repos, but 
# with the `-a` option, it will look through all directories (recursively). 

#if [ $1==='-a' ]
#then 
    #cmd="find /home/mathijs/Work/* -type d ! -path '*/.git/*'" 
#else
    #cmd="find /home/mathijs/Work/* -type d ! -path '*/.git/*' -exec test -e '{}/.git' ';' -print -prune"
#fi

#cd "$($cmd | fzf)"

qfraw() {
    cd $(find $1 -type d ! -path '*/.git/*' | fzf)
}

qfrawgit() {
    cd $(find $1 -type d ! -path '*/.git/*' -exec test -e '{}/.git' ';' -print -prune | fzf)
}

function qfgitall() {
    qfraw "/home/mathijs/*"
}

function qfwall() {
    qfraw "/home/mathijs/Work/*"
}

function qfrall() {
    qfraw "/home/mathijs/Work/Research/*" 
}


function qf() {
    qfrawgit "/home/mathijs/*"
}

function qfw() {
    qfrawgit "/home/mathijs/Work/*"
}

function qfr() {
    qfrawgit "/home/mathijs/Work/Research/*"
}

#function qf() {
    #cd $(find /home/mathijs/Work/* -type d ! -path '*/.git/*' | fzf) 
#}

