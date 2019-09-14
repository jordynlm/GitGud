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
                found_git=true

                if [[ ${args[0]} = "log" ]]; then
                    printf "%s\n" "Attempting to pull in $1"
                    echo "Attempting to pull in $1
                    " >> $org_dir/gitgud_err.txt
                    
                    ( cd $1 ; $git_command |& tee -a $org_dir/gitgud_err.txt )
                    
                    printf "%s\n" "-----------------------------------"
                    echo "-----------------------------------" >> $org_dir/gitgud_err.txt
                else
                    printf "%s\n" "Attempting to pull in $1"
                    ( cd $1 ; $git_command )
                    printf "%s\n" "-----------------------------------"
                fi
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

args=("$@")
git_command="git pull"
if [[ ${args[0]} = "push" ]]; then
    git_command="git push"
fi
if [[ ${args[1]} = "log" ]]; then
    org_dir=$(pwd)
    echo "" > gitgud_err.txt
fi
find_git_repos .

