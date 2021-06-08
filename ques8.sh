#! /bin/bash

###
# taking 2 directories as paramters this script performs bind mount operation
###

#checking if both source and destination are given 
if [ -z $1 ] || [ -z $2 ]
then
	echo "usage $0 source destination"
	exit 1
fi

#if both the inputs are present
#checking if inputs are valid directories
#checking source
if [ ! -d $1 ] 
then
	echo "source not found $1"
	exit 1
fi

#checking destination
if [ ! -d $2 ]
then
	echo "destination not found $2"
	exit 1
fi

#check if both directories are already mounted
var=$(findmnt "$2" | grep "$1")

if [ -z "$var" ]
then
	#If both directories are correct performing mount on them
	mount --bind $1 $2
	echo done
	exit 0
fi

echo "already mounted"
exit 2
