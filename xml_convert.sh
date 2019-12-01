#!/bin/bash -       
#title           :xml_convert.sh
#description     :This script will convert your csv file in to sql file 
#author		 :Darshana Kapuge
#date            :20180406
#version         :1.0
#usage		 :bash xml_convert.sh mysql
#**************************************************************************************************************************
#first cd /tmp 
#**************************************************************************************************************************
#then mkdir -p script/{csv,txt_files,sql/{1,2,finish}} 
#**************************************************************************************************************************
#then copy csv file to  /tmp/script/csv 
#**************************************************************************************************************************



for entry in  $(ls /tmp/script/csv)
do

file_name=$(echo $entry)

done



table_name=$(cat /tmp/script/csv/$file_name | cut -d, -f 15 | tail -1)
echo "#************* $table_name ****************"
unclean=$table_name"_unclean.txt"
cat /tmp/script/csv/$file_name |cut -d, -f 19,22,25 >> /tmp/script/txt_files/$unclean
ready_to_process=$table_name"_ready_to_process.txt"
cat /tmp/script/txt_files/$unclean |sed 's/,/ /g' >> /tmp/script/txt_files/$ready_to_process

echo $ "USE [MetroDiner];\n GO\n IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[$table_name]') AND type in (N'U'))\n BEGIN\n DROP TABLE [dbo].[$table_name];\n END\n GO\n SET ANSI_NULLS ON;\n GO\n SET QUOTED_IDENTIFIER ON;\n GO"

echo $"CREATE TABLE [dbo].[$table_name] ("

while read line; do    

 y=$(echo $line | awk '{print $3}')
 data_type=$(echo $line | awk '{print $2}')1
 #echo $data_type 
 new_line=$(echo $line | cut -d " " -f 1,3 )
 #echo $new_line
 count=$(echo $new_line |awk '{print $2}' | sed "s/^/\(/; s/$/\)/;")


if [ "string" = $data_type ]; 
	then 
	line2=$(echo $new_line | sed -re 's/(^\w*)/[\1]/' | sed -e 's/\s/ nvarchar/g')
		if [ $y = "0" ];
		then
		result5=$(echo $line2 |replace "$y" "(255)")
		else
		result5=$(echo $line2 |replace "$y" "$count") 
		fi
		echo $result5" NULL,"
fi

if [ "integer" = $data_type ];
	then
	line2=$(echo $new_line | sed -re 's/(^\w*)/[\1]/' | sed -e 's/\s/ int /g')
        result5=$(echo $line2 |replace "$y" "")
        echo $result5"NULL,"
fi
if [ "boolean" = $data_type ];
        then
        line2=$(echo $new_line | sed -re 's/(^\w*)/[\1]/' | sed -e 's/\s/ nvarchar /g')
        result5=$(echo $line2 |replace "$y" "")
        echo $result5"NULL,"
fi

if [ "datetime" = $data_type ];
        then
        line2=$(echo $new_line | sed -re 's/(^\w*)/[\1]/' | sed -e 's/\s/ DateTime /g')
        result5=$(echo $line2 |replace "$y" "")
        echo $result5"NULL,"
fi

if [ "number" = $data_type ];
        then
        line2=$(echo $new_line | sed -re 's/(^\w*)/[\1]/' | sed -e 's/\s/ Numeric /g')
        result5=$(echo $line2 |replace "$y" "")
        echo $result5"NULL,"
fi
if [ "date" = $data_type ];
        then
        line2=$(echo $new_line | sed -re 's/(^\w*)/[\1]/' | sed -e 's/\s/ Date /g')
        result5=$(echo $line2 |replace "$y" "")
        echo $result5"NULL,"
fi

done </tmp/script/txt_files/$ready_to_process

echo $ "ON [PRIMARY]\n WITH (DATA_COMPRESSION = NONE);\n GO\n ALTER TABLE [dbo].["$table_name"] SET (LOCK_ESCALATION = TABLE);\n GO"



sql_file=$table_name".sql"

cat /tmp/script/sql/1/$sql_file | sed 's|[$]||g' >> /tmp/script/sql/2/$sql_file

line_number=$(cat /tmp/script/sql/2/$sql_file | grep -n "NULL" | tail -1 | cut -d: -f1)
cat /tmp/script/sql/2/$sql_file | sed -e ''$line_number's/,//' >> /tmp/script/sql/finish/$sql_file 

rm -rf  	 /tmp/script/txt_files/*
rm -rf  /tmp/script/sql/1/*
rm -rf  /tmp/script/sql/2/*
