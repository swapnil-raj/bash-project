#! /bin/bash

# this script takes file with utility list and for all element prints version if utility is present

#checking  if input is present
if [ -z $1 ]
then
	echo usage $0 filename
        exit 1
fi

#checking if input file is valid
if [ ! -f $1 ]
then
	echo enter valid file
	exit 1
fi

utils=$(cat $1)

for util in $utils
do 
	ver=$(dpkg -l | grep " $util " | awk '{print $3}')
	if [ -z $ver ]
	then
		echo $util is not present
		continue
	fi

	echo $util is present and version is $ver

done<$1 #giving filename as input of while loop
