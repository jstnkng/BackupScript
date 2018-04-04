#!/bin/bash
# My first script

if [ $# = 0 ]; then
	echo "No command line arguments!"
	exit 1
fi

mkdir -p $HOME"/backup"

for var in "$@"
do
	if [ -d $var ]; then
		cp -R $var $HOME"/backup"
	elif [ -f $var ]; then
		cp -R $var $HOME"/backup"
	elif [[ $var == -* ]]; then
		if [ $var = "-c" ]; then
			file_num=$(ls -l $HOME"/backup" | wc -l)
			file_num=$((file_num-1))
			echo "Number of files in backup directory: $file_num"
			echo "Bytes used per file:"
			for file in $HOME"/backup/*"
			do
				du -b $file
			done	
		elif [ $var = "-l" ]; then
			ls $HOME"/backup"
		elif [ $var = "--help" ]; then
			echo "Type in ./backup [filesList] and then an optional command:"
			echo "-c : Display the number of files and directories plus their total size"
			echo "-l: Display files and directories in backup directory"
		else
			echo "Invalid command! Use --help for instructions."
		fi
	else
		echo "$var does not exist!"
	fi

done
exit 1
