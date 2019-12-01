#!/bin/bash 
#!Darshanak

fpath=/root/files/*

while read line 
do 
ls -t $line* | tail -n +2 | xargs -I {} rm {}
done < <(find $fpath -type f -print |cut -d_ -f1,2  | uniq)
