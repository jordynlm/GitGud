#!/bin/bash
# A script which runs through a desired text file and clones the 
# repos listed there
#the script skips any lines preceded by a '%'

#save credentials so that user does no have to reenter data
git config --global credential.helper 'cache--timeout=900'

#get file detailing repos
echo Please input the name of the file listing the repos you would like to clone...
read filename

#set destination folder
echo Would you like to clone the repos to a directory different than your current one? Y?N
read ans

if [ $ans == "Y" ]
then
	echo Please enter the path to the directory where you would like to load the repos into
	read target_dir
	cd $target_dir
fi

#get repos from file
#while IFS= read -r line
cat $filename | while read line
do
	echo "$line"

	if [[ ! $line == *"%"* ]] && [ ! -z "$line" ]  
	then
		echo "Attempting to clone: $line"
		git clone $line
	fi
done

echo "All repos $filename cloned."

