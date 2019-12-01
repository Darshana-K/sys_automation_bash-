#!/bin/bash
#!DarshanaK

down_date=$1
url="http://88.99.165.213/ondemand/NewReleases/"

wget $url  -O site.txt

while read line ;
do

full_link=$(echo $line | cut -d= -f5 )
link=$(echo $full_link | cut -d'"' -f2 )
site_date=$(echo $line | cut -d= -f6 | cut -d' ' -f1 | cut -d'>' -f2 )
#echo $full_link
#echo $link
#echo $site_date

        if [ "$down_date" == "$site_date" ]; then
echo $full_link
echo $link
echo $site_date

               	echo $line
                wget -r --no-parent --no-host-directories -R "index.html*" --cut-dirs=2 $url$link
        fi


done < site.txt
