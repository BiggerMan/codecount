#!/bin/bash

declare -i files=0
declare -i lines=0

list_alldir()
{
	for file in `ls -a $1`
	do
		if [ x"$file" != x"." -a x"$file" != x".." ];then
			if [ -d "$1/$file" ];then
				list_alldir "$1/$file"
			else
				if [[ $file =~ \.c$ ||$file =~ \.h$ ]];then
					echo "$1/$file"
					files=$files+1
					lines=$lines+`cat "$1/$file"|wc -l`
				fi
			fi
		fi
	done
}

if [ "$1" = "" ];then
	arg="."
else
	arg=$1
fi

list_alldir $arg

echo "There are $files c files under directory:$arg"
echo "--total code lines are:@$lines@"
