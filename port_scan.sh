#!/bin/bash -       
#title           :port_scan.sh
#description     :This script will scan your system open port and  popup msg  
#author		     :Darshana Kapuge [1031danrox@gmail.com]
#date            :20170716
#version         :1.0
#usage		     :bash port_scan.sh gxmessage
#**************************************************************************************************************************
#first copy script to /home 
#**************************************************************************************************************************
#install gxmessage
#sudo apt-get install gxmessage
#**************************************************************************************************************************
#add this script to crontab for every minut run
# crontab -e
# * * * * * /home/port_scan.sh
#**************************************************************************************************************************
#define any port number in grep (replace port number 23)
#**************************************************************************************************************************
data=$(netstat -tulpn | grep 23)

if [ -z "$data"];
then
echo "ok"
else
    gxmessage -center "$data"
fi
