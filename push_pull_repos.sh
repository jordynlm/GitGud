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
                    printf "%s\n" "Attempting to ${args[0]} in $1"
                    echo "Attempting to ${args[0]} in $1
                    " >> $log_file
                    
                    ( cd $1 ; $git_command |& tee -a $log_file )
                    
                    printf "%s\n" "-----------------------------------"
                    echo "-----------------------------------" >> $log_file
                else
                    printf "%s\n" "Attempting to ${args[0]} in $1"
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
    if [[ ${args[2]} != "" ]]; then
        log_file=${args[2]}
        if [[ ${log_file:0:1} != "/" && ${log_file:0:1} != "~" && ${log_file:0:1} != "." ]]; then
            org_dir=$(pwd)
            log_file=$org_dir/$log_file
        fi
    else
        org_dir=$(pwd)
        log_file=$org_dir/gitgud_err.txt
    fi
    echo "" > $log_file
fi
find_git_repos .

