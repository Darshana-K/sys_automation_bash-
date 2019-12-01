
#!/bin/bash      
#title           :.sh
#description     :Gorilla Implement with txt base Gui  
#author		 :Darshana Kapuge
#date            :20180806
#version         :1.0
#usage		 : get user infor using txt base gui and update mysql 5.7.2 database gorilla 
#**************************************************************************************************************************
#Script save user  password in file name as user_name_password.pw 
#* 

mysql_user="root"
export MYSQL_PWD="root"
name=""
new_password=""
mysql_quary=""
company_name=""
smtp_email=""
invoice_company_name=""
invoice_company_address=""
invoice_company_city=""
invoice_company_country_code=""
invoice_company_postal_code=""
invoice_company_phonenumber=""
company_vat=""
maximum_staff=""

box_fuction(){
echo $new_password
case $1 in
   0) echo "process working"
	 mysql -u$mysql_user  -e "ALTER USER '$name'@'localhost' IDENTIFIED WITH mysql_native_password BY '$new_password';"
         echo $name" mysql user password updated" 
	 old_password=$(cat /var/www/thml/app-config.php | grep APP_DB_PASSWORD | cut -d "," -f2 |awk -F "['']" '{print $2}')
	 echo $old_password
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

gui_function(){
case $1 in
   0) echo "OK";;
   1) echo "Canceled, please start again"
		exit 1 ;;
   255) echo "Unbekannter Parameter"
		exit ;;
esac
}

databases_customer_data(){
echo $1
echo $2

case $1 in
   0) mysql -u$mysql_user -Dgorilla -e"$2"
			 ;;
   1) echo "Canceled, please start again"
		exit 1 ;;
   255) echo "Unbekannter Parameter"
		exit ;;
esac

}

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
case $response in
   0) echo "lets go on ..." 
	new_password=$(dialog --title "Change mysql user password "  --backtitle "$HOSTNAME change mysql user "$name" password" --inputbox 'Enter New Password for '$name''  0 0 3>&1 1>&2 2>&3 3>&-);
	echo $new_password
	response=$?
	box_fuction $response 
	;;
   1) echo "Canceled, please start again"
    exit 1 ;;
   255) echo "Unbekannter Parameter"
    exit 1 ;;
esac

while [[ -z "$company_name" ]]
do
company_name=$(dialog --backtitle "Your Host Name : $HOSTNAME" --inputbox 'Enter your company name' 8 40 3>&1 1>&2 2>&3 3>&-)
response=$?
mysql_quary="UPDATE tbloptions SET value='$company_name' WHERE id=2;"
databases_customer_data "$response" "$mysql_quary"
done

while [[ -z "$smtp_email" ]]
do
smtp_email=$(dialog --backtitle "Your Host Name : $HOSTNAME" --inputbox 'Enter your company Email' 8 40 3>&1 1>&2 2>&3 3>&-)
response=$?
mysql_quary="UPDATE tbloptions SET value='$smtp_email' WHERE id=8;"
databases_customer_data "$response" "$mysql_quary"
done


while [[ -z "$invoice_company_name" ]]
do
invoice_company_name=$(dialog --backtitle "Your Host Name : $HOSTNAME" --inputbox 'Enter your invoice company name' 8 40 3>&1 1>&2 2>&3 3>&-)
response=$?
mysql_quary="UPDATE tbloptions SET value='$invoice_company_name' WHERE id=29;"
databases_customer_data "$response" "$mysql_quary"
done


while [[ -z "$invoice_company_address" ]]
do
invoice_company_address=$(dialog --backtitle "Your Host Name : $HOSTNAME" --inputbox 'Enter your invoice company address' 8 40 3>&1 1>&2 2>&3 3>&-)
response=$?
mysql_quary="UPDATE tbloptions SET value='$invoice_company_address' WHERE id=30;"
databases_customer_data "$response" "$mysql_quary"
done


while [[ -z "$invoice_company_city" ]]
do
invoice_company_city=$(dialog --backtitle "Your Host Name : $HOSTNAME" --inputbox 'Enter your invoice company city' 8 40 3>&1 1>&2 2>&3 3>&-)
response=$?
mysql_quary="UPDATE tbloptions SET value='$invoice_company_city' WHERE id=31;"
databases_customer_data "$response" "$mysql_quary"
done


while [[ -z "$invoice_company_country_code" ]]
do
invoice_company_country_code=$(dialog --backtitle "Your Host Name : $HOSTNAME" --inputbox 'Enter your invoice company country code' 8 40 3>&1 1>&2 2>&3 3>&-)
response=$?
mysql_quary="UPDATE tbloptions SET value='$invoice_company_country_code' WHERE id=32;"
databases_customer_data "$response" "$mysql_quary"
done


while [[ -z "$invoice_company_postal_code" ]]
do
invoice_company_postal_code=$(dialog --backtitle "Your Host Name : $HOSTNAME" --inputbox 'Enter your invoice_company postal code' 8 40 3>&1 1>&2 2>&3 3>&-)
response=$?
mysql_quary="UPDATE tbloptions SET value='$invoice_company_postal_code' WHERE id=33;"
databases_customer_data "$response" "$mysql_quary"
done


while [[ -z "$invoice_company_phonenumber" ]]
do
invoice_company_phonenumber=$(dialog --backtitle "Your Host Name : $HOSTNAME" --inputbox 'Enter your company phone number' 8 40 3>&1 1>&2 2>&3 3>&-)
response=$?
mysql_quary="UPDATE tbloptions SET value='$invoice_company_phonenumber' WHERE id=34;"
databases_customer_data "$response" "$mysql_quary"
done


while [[ -z "$company_vat" ]]
do
company_vat=$(dialog --backtitle "Your Host Name : $HOSTNAME" --inputbox 'Enter your company vat' 8 40 3>&1 1>&2 2>&3 3>&-)
response=$?
mysql_quary="UPDATE tbloptions SET value='$company_vat' WHERE id=178;"
databases_customer_data "$response" "$mysql_quary"
done


while [[ -z "$maximum_staff" ]]
do
maximum_staff=$(dialog --backtitle "Your Host Name : $HOSTNAME" --inputbox 'Enter your company maximum staff' 8 40 3>&1 1>&2 2>&3 3>&-)
response=$?
mysql_quary="UPDATE tbloptions SET value='$maximum_staff' WHERE id=355;"
databases_customer_data "$response" "$mysql_quary"
done



