#!/bin/bash      
#title           :name_change.sh
#description     :This script will modify your SAP folder as you requested 
#author		 	 :Darshana Kapuge
#date            :20180507
#version         :1.0
#usage			 :bash string manipulation 
#**************************************************************************************************************************
#save Script same loation where SAP  folder located 
#**************************************************************************************************************************

IFS='
'
NEWNAME=any_name
pwd 
mkdir zip_files
cp -R SAP backup
mv SAP $NEWNAME 
sed -i -e "s/SAP/$NEWNAME/g" $NEWNAME/build.xml 

grep $NEWNAME $NEWNAME/build.xml
echo "build.xml done"
sed -i -e "s/SAP/$NEWNAME/g" $NEWNAME/build.properties
echo "build.properties done"
grep $NEWNAME $NEWNAME/build.properties

sed -i -e "s/SAP/$NEWNAME/g" $NEWNAME/xquery-modules/sias-utility-tenant-v2.xml
echo "sias-utility-tenant-v2.xml done"
grep $NEWNAME $NEWNAME/xquery-modules/sias-utility-tenant-v2.xml | wc -l

sed -i -e "s/\<SAP\>/$NEWNAME/g" $NEWNAME/tables/metadata.xml

echo "metadata.xml done"
grep SAP $NEWNAME/tables/metadata.xml

for file in $NEWNAME/tables/SAP*1.xml
do
echo $file
    sed -i -e "s/\<SAP\>/$NEWNAME/g" $file
    mv -if "${file}" "${file//SAP/$NEWNAME}"
done


mkdir  tmp_unzip
for file in $NEWNAME/searches/*.zip
do
    echo $file
    unzip $file -d tmp_unzip/ 
sed -i -e "s/\<SAP\>/$NEWNAME/g" tmp_unzip/*
zip -m $file tmp_unzip/*
   
done



for file in $NEWNAME/searches/*.zip
do
FirstName=$file
modifyneme=$(echo $FirstName |  sed "s/ /_/g')
echo $file
echo $modifyneme
mv $file $modifyneme
unzip $modifyneme -d tmp_unzip/
sed -i -e "s/\<SAP\>/$NEWNAME/g" tmp_unzip/*
filename=$(echo $file |  cut -d '/' -f3  )
echo $filename
zip -jm zip_files/$filename tmp_unzip/*
rm -rf tmp_unzip/*
done

rm -rf $NEWNAME/searches/*.zip
mv - zip_files/*.zip $NEWNAME/searches/
rm -rf tmp_unzip
rm -rf zip_files