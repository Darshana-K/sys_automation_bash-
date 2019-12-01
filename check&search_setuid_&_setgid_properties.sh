#!/bin/bash
#search setgid files 

#search function will search both files and save to two txt files 
search(){
find / -perm -4000 > setuid.txt 
#search setuid files 
find / -perm -2000 > setgid.txt
# clean files 
sed '/find/d' -i setuid.txt 
sed '/find/d' -i setgid.txt 
#add md5 value for  setuid files 
while read line
do
md5sum "$line" > setuid_md5.txt
done < setuid.txt  
#add md5 value for  setgid files
while read line
do
md5sum "$line" > setgid_md5.txt
done < setgid.txt
}
#check fubnction will inspect two files which created by search function and if there any issue mail it 
check(){
#cross check setgid & setuid and get the different 
result=$(diff -u setgid_md5.txt setuid_md5.txt | grep '^-\|^+' | grep -v '^--\|^++' | sed 's/^-//g')

#if there any different mail it to configured mail 

if [ -n "$result" ]; then 

echo "Search result : $result" | mail -s "Security risk detected" someone@somewhere.com

fi 
}

search
	
name=$1

if [[ -n "$name" ]]; then
	check
else
    echo "argument error"
fi
