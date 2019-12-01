#!/bin/bash 
#!DarshanaK

while read  line
do

url=$( echo $line | cut -d\| -f 1 ) 
name=$( echo $line | cut -d\| -f 2 )
file_name=$name'.mkv'
wget -O "$file_name"  "${url}"

done </your/location/for/all_data.log