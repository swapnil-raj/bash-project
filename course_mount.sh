#! /bin/bash

#This script mount folder(s) as different users
usage="Usage
    ./course_mount.sh -h To print this help message
    ./course_mount.sh -m -c [course] For mounting a given course
    ./course_mount.sh -u -c [course] For unmounting a given course
If a course name is omitted all couse will be (un)mounted


Courses available:
  "linux_course/linux_course1"
  "linux_course/linux_course2"
  "machinelearning/machinelearning1"
  "machinelearning/machinelearning2"
  "sqlfundamentals1"
  "sqlfundamentals2"
  "sqlfundamentals3"
" 
#creating course array to store courses
courses=(
"linux_course/linux_course1"
"linux_course/linux_course2"
"machinelearning/machinelearning1"
"machinelearning/machinelearning2"
"sqlfundamentals1"
"sqlfundamentals2"
"sqlfundamentals3"
)

username="test" #storing username

#function to check if a course is mounted
check_mount(){
f=$(cut -d "/" -f2- <<< "$1") #getting file name
var=$(findmnt "/home/$username/$f" | grep "$1")
if [ -z "$var" ]
then
	echo 1 # if files are not mounted
else
echo 0 # if files are mounted
fi
}


# function to mount a course
mount_course(){
if [[ " ${courses[@]} " =~ " $1 " ]] #checking if value present in the array, here $1 is the course name
then
	ispre=$(check_mount $1) #checking if course is already mounted
	if [ $ispre -eq 1 ]
	then
		f=$(cut -d "/" -f2- <<< "$1") #getting course name
		mkdir /home/$username/$f #making directry to store mount
	        bindfs -p 0770:gu-w -u $username -g ftpaccess /courses/$1 /home/$username/$f #mounting
	else
		echo $1 is mounted
	fi
else
	echo "enter valid course. use $0 -h for help"
fi
}


#function to mount all courses
mount_all(){
for course in ${courses[@]}
do
	mount_course $course
done

}

#function to unmount a course
unmount_course(){
if [[ " ${courses[@]} " =~ " $1 " ]] #checking if value present in the array, here $1 is the course name
then
        ispre=$(check_mount $1) #checking if course is already mounted
        if [ $ispre -eq 0 ]
        then
                f=$(cut -d "/" -f2- <<< "$1") #getting course name
                umount /courses/$1 /home/$username/$f #unmounting course
		rmdir /home/$username/$f #removing course directory

        else
                echo $1 is not mounted
        fi
else
        echo "enter valid course. use $0 -h for help"
fi

}

#function to unmount all course
unmount_all(){
for course in ${courses[@]} #traversing via course array
do
         unmount_course $course #unmounting course one by one
done

}

#creating a menu

while getopts 'hmu' option
do 
case "$option" in
	h) echo -e  "$usage" #printing help menu
	  exit 0
	;;
	m) echo  m option
	  if [ ! -z $2 ] #checking variable is present or not
	  then
		if [ -z $3 ] #if c option is given then checking for course name
		then
			echo "enter course name, see help for available courses"
			exit 1
		fi
		mount_course $3 $mounting course
		exit 0

	  fi
	  mount_all  #if c is not given mounting all course
	  exit 0
	;;
	u) echo  u option
          if [ ! -z $2 ] #checking variable is present or not

          then
                if [ -z $3 ] #if c option is given then checking for course name
                then
                        echo "enter course name, see help for available courses"
                        exit 1
                fi
                unmount_course $3
                exit 0

          fi
          unmount_all
          exit 0
	;;
	\?) echo "invalid option, use -h for help"
	exit 0
	;;
esac
done

echo $1
