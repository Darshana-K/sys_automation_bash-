#!/bin/bash 
#!DarshanaK
#path=""
check() { 

eval sctring1="$1"

if  [ ! -z "${sctring1}" -a "${sctring1}" != " " ];
then
echo "$sctring1" >> result.txt

else
echo "Nothing" >> result.txt
fi

}

host_name=$(grep  hostname  router.txt)
check "\${host_name}" 

domain=$(grep "domain-name" router.txt)
check "\${domain}"

ip_address=$(grep "ip address" router.txt | cut -d " " -f3 | sed 's/[^0-9,.]*//g')
check "\${ip_address}" 

passwd_encryp=$(grep  "password-encryption" router.txt)
check "\${passwd_encryp}" 

enable_secret=$( grep "enable secret" router.txt ) 
check "\${enable_secret}"

banner1=$(grep  "banner motd"  router.txt)
check "\${banner1}"

banner2=$(grep  "banner login"  router.txt)
check "\${banner2}"

banner3=$(grep  "banner exec"  router.txt)
check "\${banner3}"