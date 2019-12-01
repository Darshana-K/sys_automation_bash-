#!/bin/bash
#Disclaimer
#defien mysql user details 

mysql_user="root"
export MYSQL_PWD="root"
name=""
new_password=""
box_fuction(){
echo $new_password
case $1 in
   0) echo "process working"
	 mysql -u$mysql_user  -e "ALTER USER '$name'@'localhost' IDENTIFIED WITH mysql_native_password BY '$new_password';"
         echo $name" mysql user password updated" 
	 old_password=$(cat /var/www/thml/app-config.php | grep APP_DB_PASSWORD | cut -d "," -f2 | awk -F "['']" '{print $2}' )
	 echo $old_password ;
	 sed -i "s/$old_password/$new_password/g" /var/www/thml/app-config.php
	 echo "changed password for user $name in /var/www/thml/app-config.php"
	 echo "user $name changed to new password : $new_password" >$name"_password.pw"
	;;
   1) echo "Canceled, please start again"
                exit 1 ;;
   255) echo "Unbekannter Parameter"
                exit ;;
esac
}
#mysql database  update with customer detais 

customer_data_update(){
mysql_quary=$2
case $1 in
   0) echo "lets go on ..." 
       mysql -uroot -e "$mysql_quary" 
        ;;
   1) echo "Canceled, please start again"
    exit 1 ;;
   255) echo "Unbekannter Parameter"
    exit 1 ;;
esac

}


# Get exit status
# 0 means user hit [yes] button.
# 1 means user hit [no] button.
# 255 means user hit [Esc] key.
gui_function(){
case $1 in
   0) echo "OK";;
   1) echo "Canceled, please start again"
		exit 1 ;;
   255) echo "Unbekannter Parameter"
		exit ;;
esac
}


echo "---------------------------"
echo "-- Auto Gorilla install ---"
echo ""
echo "--------- V 1.1 SSL -------"
echo ""
echo "------- (C) stoffl --------"
echo "---------------------------"
echo ""

#short name question
#echo ""
#name=$(dialog --inputbox 'Enter your name' 8 40 3>&1 1>&2 2>&3 3>&-)
while [[ -z "$name" ]]
do
name=$(dialog --inputbox 'Enter your name' 8 40 3>&1 1>&2 2>&3 3>&-)
response=$?
gui_function $response
done
#Check Name
dialog --title "Check Name" \
--backtitle 'Eingabe: '$name' richtig ' \
--yesno 'Eingabe: '$name' richtig? Y/N:' 7 60
response=$?
gui_function $response

#Check hostname
dialog --title "Check hostname" \
--backtitle "Eingabe: $HOSTNAME" \
--yesno "Eingabe: $HOSTNAME richtig? Y/N" 7 60
response=$?
gui_function $response

case $response in
   0) echo "lets go on ..." 
	new_password=$(dialog --title "Change mysql user password "  --backtitle "change mysql user "$name" password" --inputbox 'Enter New Password for '$name''  0 0 3>&1 1>&2 2>&3 3>&-);
	echo $new_password
	response=$?
	box_fuction $response 
	;;
   1) echo "Canceled, please start again"
    exit 1 ;;
   255) echo "Unbekannter Parameter"
    exit 1 ;;
esac


while [[ -z "$name" ]]
do
name=$(dialog --inputbox 'Enter your name' 8 40 3>&1 1>&2 2>&3 3>&-)
response=$?
gui_function $response
done

