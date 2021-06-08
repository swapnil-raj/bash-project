#! /bin/bash
#This script is to show current file system

#below command prints the current file system
echo $(df -a --output=source $PWD)
