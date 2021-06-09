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

utils=$(cat $1) # storing files contents in util

for util in $utils
do 
	ver=$(dpkg -l | grep " $util " | awk '{print $3}') #getting version of utility
	if [ -z $ver ] #if util is not present ver will be empty
	then
		echo $util is not present
		continue
	fi

	#printing version of utility
	echo $util is present and version is $ver

done
