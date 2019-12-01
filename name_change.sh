#!/bin/bash 
#!Darshana kapuge 
IFS='
'

pwd 
mkdir zip_files
cp -R SAP backup
mv SAP ch_nm_x 
sed -i -e 's/SAP/ch_nm_x/g' ch_nm_x/build.xml 

grep ch_nm_x ch_nm_x/build.xml
echo "build.xml done"
sed -i -e 's/SAP/ch_nm_x/g' ch_nm_x/build.properties
echo "build.properties done"
grep ch_nm_x ch_nm_x/build.properties

sed -i -e 's/SAP/ch_nm_x/g' ch_nm_x/xquery-modules/sias-utility-tenant-v2.xml
echo "sias-utility-tenant-v2.xml done"
grep ch_nm_x ch_nm_x/xquery-modules/sias-utility-tenant-v2.xml | wc -l

sed -i -e 's/\<SAP\>/ch_nm_x/g' ch_nm_x/tables/metadata.xml

echo "metadata.xml done"
grep SAP ch_nm_x/tables/metadata.xml

for file in ch_nm_x/tables/SAP*1.xml
do
echo $file
    sed -i -e 's/\<SAP\>/ch_nm_x/g' $file
    mv -if "${file}" "${file//SAP/ch_nm_x}"
done


mkdir  tmp_unzip
for file in ch_nm_x/searches/*.zip
do
    echo $file
    unzip $file -d tmp_unzip/ 
sed -i -e 's/\<SAP\>/ch_nm_x/g' tmp_unzip/*
zip -m $file tmp_unzip/*
   
done



for file in ch_nm_x/searches/*.zip
do
FirstName=$file
modifyneme=$(echo $FirstName |  sed 's/ /_/g')
echo $file
echo $modifyneme
mv $file $modifyneme
unzip $modifyneme -d tmp_unzip/
sed -i -e 's/\<SAP\>/ch_nm_x/g' tmp_unzip/*
filename=$(echo $file |  cut -d '/' -f3  )
echo $filename
zip -jm zip_files/$filename tmp_unzip/*
rm -rf tmp_unzip/*
done

rm -rf ch_nm_x/searches/*.zip
mv - zip_files/*.zip ch_nm_x/searches/
rm -rf tmp_unzip
rm -rf zip_files
