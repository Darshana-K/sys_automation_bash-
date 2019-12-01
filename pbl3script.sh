#!/bin/bash
#!darshanak

HOSTNAME=$(hostname)
USER=$(whoami)
DATE=`date +%Y%m%d`
DOW=$(date +%A)

echo $DOW
echo $DATE
echo $HOSTNAME
echo $USER

#Q1
[ -d ~/backup/$DOW ] || mkdir ~/backup/$DOW 

sudo tar -zcvf ~/backup/$DOW/$HOSTNAME-$USER-$DATE.tgz /home/$USER --exclude "/home/$USER/backup/*"
#Q2
sudo tar -zcvf ~/backup/$DOW/$HOSTNAME-$DATE.tgz /etc /opt /var  --exclude "/home/$USER/backup/*"
#Q3
sudo apt-get clean all -y 
sudo apt-get -y update -y 
sudo apt-get -y dist-upgrade -y 

#Q4
disk_space=$(df -H / | awk '{ print $4}')

echo "Amount of disk space available in the root /" $disk_space

#Q5
echo "Amount of memory and swap memory in the system"
free -m | awk '{print $1 $2 }' | tail -n 2 
#Q6
echo "Amount of disk space the "$USER" home directory occupies "
du -sh  ~

#Q7
SIZE=$(du -sh ~ | awk '{print $1}'|sed 's/[^0-9]*//g')
CHECK=500
if (( $(echo "$CHECK < $SIZE" |bc -l) )); then
        echo $USER " FOlder is FULL  "
fi



