#!/bin/bash
#!darshanak

#DEFINE YOUR PASSWORD HERE also if your password has special charactors then add '\' before it 
password="P\@ssword\!2017"
file_name=$(date +"%Y%m%d")

file_locate=$(find . -name $file_name* 2>&1 | grep -v 'Permission denied')

extention=$(echo $file_locate | awk -F. '{print $3}')
echo $extention 

if [ "$extention" == "zip" ]; then 
unzip -P$password $file_locate
find . -name $file_name.zip  -exec rm -rf {} \;
else
unrar e -p$password $file_name.rar
find . -name $file_name.rar  -exec rm -rf {} \;
fi


echo "extrac the files from "$file_locate" file !!!!!!  HAVE A NICE DAY  !!!!!!! " 

#unrar e -p$password $file_name.rar
#find the file and remove it 
#find . -name $file_name.rar  -exec rm -rf {} \;

