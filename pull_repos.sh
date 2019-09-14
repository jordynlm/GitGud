#!/usr/bin/env bash

for f in *; do
    if [[ -d ${f} && ! -L ${f} ]]; then
        echo $f
    fi
done
