
#!/bin/bash
#!darshanak

log="/tmp/file_remove.log"

path=$1
echo "Script Starting all the files in $path with extention AFP_AfpInfo will be removed " 
echo "$path"
find "$path" -name \*AFP_AfpInfo 
#find $path -name \*AFP_AfpInfo -exec rm -rf {} \;


