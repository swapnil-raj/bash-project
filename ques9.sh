#! /bin/bash
# script shows all the files and their mounts
while read i 
do 
echo $i
done< <(sudo df -a --output=source,target,fstype) #this command helps printing source destination and filesytem type
