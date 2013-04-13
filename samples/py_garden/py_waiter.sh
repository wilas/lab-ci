#!/bin/bash

# script to:
# - add or remove code to git repos
# - run behave tests


# {git repo, directories} patterns 
patterns=(
"py_beer_flask*" "py_beer_tornado" "py_simple_tdd"
)
# git server url
urlbase='ssh://gitolite3@77.77.77.131'

function usage {
    echo "Usage: $0"
    echo "Add or remove code to all matching pattern git repos"
    echo ""
    echo "Ordering options:"
    echo "-r, --remove, Remove .git from all directories in py_garden"
    echo "-a, --add, Init git repo and make first commit"
    echo "-b, --behave, Run behave tests"
    echo "-h, --help, Display this help and exit"
    echo ""
}

function add {
    array_length=${#patterns[@]}

    # process each pattern
    for (( item = 0 ; item < $array_length ; item++ )); do
        # process all dir match pattern
        for dir in ${patterns[${item}]}; do
            cd $dir
            pwd
            # fresh init
            git init
            git add -A
            git commit -m 'fresh mint'
            git remote add origin "$urlbase/$dir.git"
            git push origin master
            git status
            cd ..
        done
    done
}

function remove {
    array_length=${#patterns[@]}

    # process each pattern
    for (( item = 0 ; item < $array_length ; item++ )); do
        # process all dir match pattern
        for dir in ${patterns[${item}]}; do
            #cleaning
            cd $dir
            pwd
            rm -rf '.git'
            cd ..
        done
    done
}

function run_behave {
    array_length=${#patterns[@]}

    # process each pattern
    for (( item = 0 ; item < $array_length ; item++ )); do
        # process all dir match pattern
        for dir in ${patterns[${item}]}; do
            #cleaning
            cd $dir
            pwd
            behave
            cd ..
        done
    done
}

OPTS=`getopt -o rhab --long remove,help,add,behave -- "$@"`
eval set -- "$OPTS"

while true ; do
case "$1" in
        -h | --help ) usage; exit ;;
        -r | --remove ) remove; shift;;
        -a | --add ) add; shift;;
        -b | --behave ) run_behave; shift;;
        ? ) usage; exit ;;
        -- ) shift; break ;;
        esac
done

