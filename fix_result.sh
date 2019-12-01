#!/bin/bash
#!darshanak 
PASS_MAX=$(cat /etc/login.defs | grep -v '^[[:space:]]*[#;]' |grep PASS_MAX_DAYS )
echo $PASS_MAX
sed -i "s/$PASS_MAX/PASS_MAX_DAYS  90/g" /etc/login.defs
cat /etc/login.defs | grep -v '^[[:space:]]*[#;]' |grep PASS_MAX_DAYS 


PASSMIN_DAYS=$(cat /etc/login.defs | grep -v '^[[:space:]]*[#;]' |grep PASS_MIN_DAYS )
echo $PASSMIN_DAYS
sed -i "s/$PASSMIN_DAYS/PASS_MIN_DAYS	10/g" /etc/login.defs
cat /etc/login.defs | grep -v '^[[:space:]]*[#;]' |grep PASS_MIN_DAYS


PASSMIN_LEN=$(cat /etc/login.defs | grep -v '^[[:space:]]*[#;]' |grep PASS_MIN_LEN )
echo $PASSMIN_LEN
	if [[ -z "$PASSMIN_LEN" ]] ; then
 	echo  "PASS_MIN_LEN not set it this host";
	else
	sed -i "s/$PASSMIN_LEN/PASS_MIN_LEN   5/g" /etc/login.defs
	cat /etc/login.defs | grep -v '^[[:space:]]*[#;]' |grep PASS_MIN_LEN
	fi

PASSWARN_AGE=$(cat /etc/login.defs | grep -v '^[[:space:]]*[#;]' |grep PASS_WARN_AGE )
echo $PASSWARN_AGE
sed -i "s/$PASSWARN_AGE/PASS_WARN_AGE   30/g" /etc/login.defs
cat /etc/login.defs | grep -v '^[[:space:]]*[#;]' |grep PASS_WARN_AGE

if [ $(dpkg-query -W -f='${Status}' libpam-cracklib  2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install libpam-cracklib -y ;
fi

pwquality=$(cat /etc/pam.d/common-password | grep -v '^[[:space:]]*[#;]' |grep "requisite")
rule="password requisite pam_cracklib.so retry=3 minlen=10 difok=3 ucredit=-1 lcredit=-1 dcredit=-1  ocredit=-1"
echo $rule
echo $pwquality

sed -i "s/$pwquality/$rule/g" /etc/pam.d/common-password

null_password_users=$(getent shadow | cut -d: -f1-2 | grep ':$' | cut -d: -f1)

echo $null_password_users

if [ ! -z $null_password_users ];  then
while read  line; do
        echo $line
        read -p "Please Enter NEW Password to user "$line" ..  "  user_password  </dev/tty
        echo -e "$user_password\n$user_password" | passwd $line
done <<< "$null_password_users"
fi


uid0_users=$(getent passwd 0| cut -d: -f1)

echo "following users has UID 0" $uid0_users ;

while read line; do
read -p "Are you sure? "$line" user permission change-- Y or n "  REPLY </dev/tty
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
usermod -u 500 -o $line
fi
done <<< "$uid0_users"


#Check the command line interface timeout time
export TMOUT=600

#Check system core dump settings

sed -i '/soft    core/s/^#//g' /etc/security/limits.conf
sed -i '/hard    core/s/^#//g' /etc/security/limits.conf

hard_line=$(cat /etc/security/limits.conf |grep "hard    core")
soft_line=$(cat /etc/security/limits.conf |grep "soft    core")
sed -i "s/$hard_line/*               hard    core            0/g" /etc/security/limits.conf
sed -i "s/$soft_line/*               soft    core            0/g" /etc/security/limits.conf


find / -name 'hosts.equiv' -exec bash -c 'mv $0 ${0/hosts.equiv/hosts.equiv.bak}' {} \;
find / -name '.rhosts' -exec bash -c 'mv $0 ${0/.rhosts/.rhosts.bak}' {} \;


histfilesize=$(cat ~/.bashrc| grep -v '^[[:space:]]*[#;]' |grep  "HISTFILESIZE")
histsize=$(cat ~/.bashrc| grep -v '^[[:space:]]*[#;]' |grep "HISTSIZE")

echo $histfilesize
echo $histsize

sed -i "s/$histfilesize/HISTFILESIZE=5/g" ~/.bashrc
sed -i "s/$histsize/HISTSIZE=5/g" ~/.bashrc

#Check if the used space of the system disk root partition is maintained below 80%	
disk_size=$(df -P | awk '0+$5 >= 80 {print}')
if [[ ! -z "$disk_size" ]]; then
echo "following disk filled over 80% " 
echo $disk_size 
fi


#Check if the PAM authentication module is used to prohibit users other than the wheel group from being su.

if [ $(cat /etc/pam.d/su 2>/dev/null | grep -v '^[[:space:]]*[#;]' |grep -c "required pam_wheel.so") -eq 0 ];
then
echo "if work for required pam_wheel.so"
  sed -i '1s/^/auth    required     pam_wheel.so\n/' /etc/pam.d/su
fi

if [ $(cat /etc/pam.d/su 2>/dev/null | grep -v '^[[:space:]]*[#;]' |grep -c "sufficient pam_rootok.so") -eq 0 ];
then
echo "if work for sufficient pam_rootok.so"
  sed -i '2s/^/auth    sufficient     pam_rootok.so\n/' /etc/pam.d/su
fi

#Check if the login limit for the system account is
while read line; do
login=$(echo $line |cut -d : -f2)
user_n=$(echo $line |cut -d : -f1)
case $login in
"*") echo $user_n" interactive login"
;;
"!!")echo $user_n" interactive login"
;;
"!")echo $user_n" interactive login"
;;
*)      read -p "Do you need interactive "$user_n" log in  Y/N:" answer </dev/tty
        case "$answer" in
        Yes|yes|j|J|Y|y|"") 
         passwd -l $user_n
            ;;
        esac
;;
esac
done </etc/shadow


#Check password reuse limit
sed -i '/pam_unix.so/ s/$/ remember = 5/' /etc/pam.d/common-password


#Check if packet forwarding is disabled

sysctl -w net.ipv4.ip_forward=0


#Check if IP masquerading and binding multi-IP are disabled

ip_masquerad=$(cat /etc/host.conf | grep -v '^[[:space:]]*[#;]' |grep nospoof )
echo $ip_masquerad
if [[ ! -z "$ip_masquerad" ]]; then
sed -i "s/$ip_masquerad/nospoof on/g" /etc/host.conf
else
echo "nospoof   on" >>/etc/host.conf
fi
echo "nospoof ON" 

ip_mult=$(cat /etc/host.conf | grep -v '^[[:space:]]*[#;]' |grep multi)
echo $ip_mult
if [[ ! -z "$ip_mult" ]];
then

sed -i "s/$ip_mult/multi   off/g" /etc/host.conf 
else
echo "multi   off" >>/etc/host.conf
fi

#Check system kernel parameter configuration

sysctl -w net.ipv4 .conf.all.accept_source_route="0"
sysctl -w net.ipv4 .conf.all.accept_redirects="0"
sysctl -w net.ipv4 .conf.all.send_redirects="0" 
sysctl -w net.ipv4.ip_forward="0"
sysctl -w net.ipv4.icmp_echo_ignore_broadcasts="1"

#Check if ssh is successfully logged in and Banner is set.

if [ ! -f /etc/motd ]; then
    echo "Login success. All activity will be monitored and reported " > /etc/motd 
else
echo "Login success. All activity will be monitored and reported " >> /etc/motd 
fi


#Check if you need to configure the minimum permissions required by the user
chmod 644 /etc/passwd
chmod 644 /etc/group
chmod 600 /etc/shadow


#Check important directory or file permission settings

chmod 600 /etc/xinetd.conf	

chmod 644 /etc/group	

chmod 400 /etc/shadow	

chmod 644 /etc/services	

chmod 600 /etc/security	

chmod 644 /etc/passwd	

chmod 750 /etc/rc6.d	

chmod 750 /tmp	

chmod 750 /etc/rc0.d/	

chmod 750 /etc/rc1.d/	

chmod 750 /etc/rc2.d/	

chmod 750 /etc/	

chmod 750 /etc/rc4.d	

chmod 750 /etc/rc5.d/	

chmod 750 /etc/rc3.d	

chmod 750 /etc/rc.d/init.d/

chmod 600 /etc/grub.conf
chmod 600 /boot/grub/grub.conf
chmod 600 /etc/lilo.conf


#Check important directory or file permission settings


