#!/bin/bash
#Disclaimer
echo "---------------------------"
echo "-- Auto Gorilla install ---"
echo ""
echo "--------- V 1.1 SSL -------"
echo ""
echo "------- (C) stoffl --------"
echo "---------------------------"
echo ""

#short name question
echo ""
read -p "Bitte Name eingeben. zb.: update:" name
echo ""


#Check Name
echo ""
read -p "Eingabe: $name richtig? Y/N:" answer

case "$answer" in
        Yes|yes|j|J|Y|y|"") echo "OK"
            ;;
        No|no|N|n) echo "Canceled, please start again"
                   exit 1
            ;;
            *) echo "Unbekannter Parameter"
            	exit 1
            ;;
esac

#Check hostname
echo ""
read -p "Eingabe: $HOSTNAME richtig? Y/N:" answer

case "$answer" in
        Yes|yes|j|J|Y|y|"") echo "lets go on ..."
            ;;
        No|no|N|n) echo "Canceled, please start again"
                   exit 1
            ;;
            *) echo "Unbekannter Parameter"
            	exit 1
            ;;
esac

LOG_FILE=install.log

exec > >(tee -a ${LOG_FILE} )
echo $(date -u)
exec 2> >(tee -a ${LOG_FILE} >&2)
echo $(date -u)

#Upgrade Linux
apt-get update  
apt-get install $1 -y
echo "Update OK"

#Crontab write
line="*/1 * * * * /usr/bin/wget -q -O- https://$name.gorilla.cc/cron/index >> /var/log/gorilla-cron.log"
(crontab -u root -l; echo "$line" ) | crontab -u root -
echo "Crontab OK"

#clean up
sudo rm -r  /var/www/html/uploads/expenses/* /var/www/html/uploads/clients/* /var/www/html/uploads/projects/25/ /var/www/html/uploads/projects/27/ /var/www/html/uploads/projects/46/ /var/www/html/backups/*
echo "Clean UP OK"

#apicron
sed -i "s/update.gorilla.cc/$name.gorilla.cc/g" /etc/apticron/apticron.conf
echo "Apticron OK"

#App Config URL
sed -i "s/update/$name/g" /var/www/html/app-config.php
echo "APP Config OK"

#Zabbix change
sed -i "s/ip-172-31-11-12/$HOSTNAME/g" /etc/zabbix/zabbix_agentd.conf
service zabbix-agent restart
echo "zabbix OK"

#Redirect change
sed -i "s/update/$name/g" /etc/apache2/sites-enabled/000-default.conf
echo "Redirect OK"

#Filepermissions to 777
sudo chmod -R 777 /var/www/html/media/ /var/www/html/uploads/ /var/www/html/upgrade/ /var/www/html/application/ /var/www/html/assets/ /var/www/html/version.txt /var/www/html/temp/ /var/www/html/plugins
echo "Ddateirechte OK"

#redirect SSL 
sed -i "s/ServerAlias update.gorilla.cc/ServerAlias $name.gorilla.cc/g" /etc/apache2/sites-enabled/000-default-le-ssl.conf
echo "Server Alias in SSL file"

service apache2 restart
echo "Apache Restart"

echo "-----------"
echo "Neustart empfohlen"
echo "sudo crontab -e anpassen"


