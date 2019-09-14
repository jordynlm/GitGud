#!/bin/bash

function clone_all_dirs()
{
	dir=$(dirname $0)
	repos=$(python3 $dir/get_repo_list.py $1 $2)
	for repo in $repos
	do
		git clone "https://github.com/$1/$repo"
	done
}

clone_all_dirs $1 $2
