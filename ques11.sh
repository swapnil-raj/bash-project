#! /bin/bash
#script to print all dates from current date till end of the month
dno=$(date +%m) #checking current month
cur_dno=$(date +%m) #storing into one more var
count=0 #count to increase the date
while [ $dno = $cur_dno ] #looping until month changes
	do
		cur_date=$(date -d "+$count days" +%d-%B-%y) #storing date of current date+ count
		echo $cur_date
		((count=$count+1)) #increasing count to see next date
		dno=$(date -d "+$count days" +%m) # storing next date's month
		
	done

