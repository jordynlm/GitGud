#!/bin/bash

shopt -s dotglob

function print_all_dirs {
    TABS=""
    for ((i = 0; i < $2; i++))
    do
        TABS="$TABS\t"
    done

    for f in $1/*; do
        if [[ -d ${f} && ! -L ${f} ]]; then
            printf "$TABS"
            printf "%s\n" "$f"
            print_all_dirs $f $2+1
        fi
    done
}

function find_git_repos {
    found_git=false
    for f in $1/*; do
        if [[ -d ${f} && ! -L ${f} ]]; then
            if [[ ${f:(-4)} = ".git" ]]; then
                printf "%s\n" "Attempting to push in $1"
                found_git=true
                ( cd $1 ; git push )
                printf "%s\n" "-----------------------------------"
            fi
        fi
    done

    if [[ $found_git = false ]]; then
        for f in $1/*; do
            if [[ -d ${f} && ! -L ${f} ]]; then
                find_git_repos $f
            fi
        done
    fi
}

find_git_repos .

