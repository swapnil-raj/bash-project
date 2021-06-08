#! /bin/bash
# script to check difference between two given dates
# script takes two dates as params

#check if we have both input
if [ -z $1 ] || [ -z $2 ]
then
        echo "usage $0 date1 date2"
        exit 1
fi

#checking if both inputs are in correct format
#for first input
date -d $1 1> /dev/null #gives exit code 0 if there is no error
if [ $? -ne 0 ] #checking last exit code
then
	echo wrong date format date1
	exit 1
fi

#for second input
date -d $2 1> /dev/null #gives exit code 0 if there is no error
if [ $? != 0 ] #checking last exit code
then
        echo wrong date format date2
        exit 1
fi

#if everything is correct
#convert both dates to seconds since epochs, subtract the, and convert seconds into days
s1=$(date -d "$1" +%s) # seconds for 1st input
s2=$(date -d "$2" +%s) # seconds for 2nd input
diff=$((($s1-$s2)/86400)) # converting seconds into days

diff=${diff#-}

echo Difference is $diff days


