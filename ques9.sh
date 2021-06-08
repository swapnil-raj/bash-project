#! /bin/bash
# script shows all the files and their mounts
while read i 
do 
echo $i
done< <(sudo df -a --output=source,target,fstype)
