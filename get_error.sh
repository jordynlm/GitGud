#!/bin/bash

function get_error()
{
    	error=$(eval $1 2>>gitgud_error_output.txt)
	python3 gitgudstackoverflow.py gitgud_error_output.txt
	rm gitgud_error_output.txt
}

get_error "$1"
