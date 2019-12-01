while read line 
do 

sudo ssh -n $line < commands.sh 



done < Legacy_servers.txt
