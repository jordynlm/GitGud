#!/bin/bash

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

function print_tabs {
    for ((i = 0; i < $1; i++))
    do
        printf "\t"
    done
    printf "here\n"
}

print_all_dirs . 0

