#!/bin/bash
#Srikanth Kallu
NOW=$(date +"%m-%d-%Y")

while read -r line; do
status=$(ssh -o BatchMode=yes -o ConnectTimeout=5 -n $line "echo ok" 2>&1)

if [[ $status = *"ok"* ]]; then
	if [[ $(ssh -o BatchMode=yes -o ConnectTimeout=5 -n $line "java -version" 2>&1) == *"OpenJDK"* ]];
		then
			echo $line >> servers_with_OpenJDK.txt 
		else
			echo $line >> servers_with_OracleJava.txt
	fi
else
echo $line "server connection error " >> server_connection_fail.txt
fi

done < serverlist.eric