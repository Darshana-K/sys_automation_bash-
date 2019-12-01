#!/bin/bash 
#!DarshanaK

help_message() {
  cat <<- _EOF_
  Options:
  -c, --find-c  Display all files with extension of C in $DIRECTORY  exit.
  -s, --find-s  Display all files over 100KB in $DIRECTORY
  -l, --find-l  Finds all log files in $DIRECTORY

_EOF_
return
}

while :
do
/bin/echo -e "\e[1;31mpress ctrl+c to exit\e[0m"
echo  "Please enter the file Path"
read DIRECTORY
if [ -d "$DIRECTORY" ]; then


   echo " dir exit $DIRECTORY"
        help_message
        read option
 
  case $option in
   
    -c | --sysname)
     find $DIRECTORY -name *.C ;; #Display all files with extension of C in given path 
    -s | --domname)
     find $DIRECTORY -type f -size +100k ;; #Display all files over 100KB from that path 
    -l | --ipaddr)
      find $DIRECTORY -name *.log;; #Finds all log files in that given path
    -* | * | --*)
      usage
      error_exit "Unknown option $option" ;; #any other invalid options
  esac

else 

echo " issue Please type it ";

fi


done
