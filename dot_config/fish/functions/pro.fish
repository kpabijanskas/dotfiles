function pro
    set SEARCH (string join " " $argv)
    set DIRECTORIES ~/repos
    set -a DIRECTORIES ~/workspaces

    for dir in $DIRECTORIES
        set repo_list $(fd '\.git$' $dir --prune -utd | sed 's/\/\.git\/$//g'|awk '{ if (NR == 1 || !index($0, prev)) { print; prev = $0 } }')
        for repo in $repo_list
            set -a REPOS $repo
        end
    end


    set TARGET $(echo $REPOS | tr ' ' '\n' |fzf --query=$SEARCH)
    if test -z $TARGET
        return
    end

    cd $TARGET
end
