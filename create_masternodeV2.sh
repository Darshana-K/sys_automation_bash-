#!/bin/bash
#!DarshanaK
SCRIPT_PATH=`pwd`
echo $SCRIPT_PATH
node_count=$1
user_count=$2
#ex_ip=$(dig @resolver1.opendns.com ANY myip.opendns.com +short)
#echo $ex_ip

if [ ! -f /tmp/Wolfcoin_linux_18_04_daemon.tar.gz ]; then
echo "node source downloading to /tmp ......."
wget https://www.wolfpackbot.com/Wallet/Wolfcoin_linux_18_04_daemon.tar.gz -P /tmp/
fi 

if [ $node_count -eq 1 ] ; then

	user_name=wolfcoin$user_count
        echo $user_name
        sudo adduser $user_name --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
        echo "$user_name:Poker8989@" | sudo chpasswd
        echo "add user to sudo users"
        sudo usermod -aG sudo  $user_name
        sed -i '/^#*root/a '$user_name' ALL=(ALL:ALL) ALL'  /etc/sudoers
        echo "Unpacking node application "
        su $user_name -c 'tar -zxf /tmp/Wolfcoin_linux_18_04_daemon.tar.gz -C /home/'$user_name''
        echo "runing application"
        cd /home/$user_name/Wolfcoin_linux_18_04_daemon/
        su $user_name -c './wolfcoind -daemon'
	if [ ! -f /tmp/config_file ]; then 
		cp $SCRIPT_PATH/config_file /tmp/
        	chmod 777 /tmp/config_file
	fi 
	su $user_name -c 'cat /tmp/config_file > /home/'$user_name'/.wolfcoin/wolfcoin.conf'
	read -p "enter ip address" ex_ip 
        su $user_name -c 'sed -i 's/my_ip/$ex_ip/g' /home/'$user_name'/.wolfcoin/wolfcoin.conf'
        read -p "enter rpc port : " rpc_port
        su $user_name -c 'sed -i "/rpcport/ s/1111/'$rpc_port'/"  /home/'$user_name'/.wolfcoin/wolfcoin.conf' 
        read -p "enter masternode key : " mkey
        su $user_name -c 'sed -i "/masternodeprivkey/ s/masternodegenkeyvalue/'$mkey'/"  /home/'$user_name'/.wolfcoin/wolfcoin.conf'
	./wolfcoin-cli stop
	#pkill -9 -f wolfcoind
        su $user_name -c './wolfcoind -daemon'
	su $user_name -c './wolfcoin-cli getinfo'
		echo "sentinel Implement start " 
        echo "-------------------------------------------------------------------------------------"
        sudo ufw limit ssh/tcp
        sudo ufw allow 4836/tcp
        sudo ufw default allow outgoing
        sudo ufw status
        cd /home/$user_name/.wolfcoin
        apt-get update
        apt-get -y install python-virtualenv
        su $user_name -c 'git clone https://github.com/dashpay/sentinel.git && cd sentinel'
	cd /home/$user_name/.wolfcoin/sentinel/
	       apt-get install virtualenv
        su $user_name -c 'virtualenv ./venv'
        su $user_name -c './venv/bin/pip install -r /home/'$user_name'/.wolfcoin/sentinel/requirements.txt'

        echo "dash_conf=/home/"$user_name"/.wolfcoin/wolfcoin.conf" >> /home/$user_name/.wolfcoin/sentinel/sentinel.conf
        crontab -l | { cat; echo "* * * * * cd /home/"$user_name"/.wolfcoin/sentinel && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1"; } | crontab -
        crontab -l | { cat; echo "@reboot cd /home/"$user_name"/Wolfcoin_all_linux && ./wolfcoind"; } | crontab -


       
else 

loop_end=$(($user_count+$node_count))

echo $loop_end
	for (( c=$user_count; c<$loop_end; c++ ))
	do 
	user_name=test$c
        echo $user_name
   	sudo adduser $user_name --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
        echo "$user_name:Poker8989@" | sudo chpasswd
        echo "add user to sudo users"
        sudo usermod -aG sudo  $user_name
        sed -i '/^#*root/a '$user_name' ALL=(ALL:ALL) ALL'  /etc/sudoers
        echo "Unpacking node application "
        su $user_name -c 'tar -zxf /tmp/Wolfcoin_linux_18_04_daemon.tar.gz -C /home/'$user_name''
        echo "runing application"
        cd /home/$user_name/Wolfcoin_linux_18_04_daemon/
        su $user_name -c './wolfcoind -daemon'
	if [ ! -f /tmp/config_file ]; then
		echo "Config file replaicated" 
                cp $SCRIPT_PATH/config_file /tmp/
                chmod 777 /tmp/config_file
        fi
        su $user_name -c 'cat /tmp/config_file > /home/'$user_name'/.wolfcoin/wolfcoin.conf'
        read -p "enter ip address" ex_ip
        su $user_name -c 'sed -i 's/my_ip/$ex_ip/g' /home/'$user_name'/.wolfcoin/wolfcoin.conf'
        read -p "enter rpc port : " rpc_port
	su $user_name -c 'sed -i "/rpcport/ s/1111/'$rpc_port'/"  /home/'$user_name'/.wolfcoin/wolfcoin.conf'
        read -p "enter masternode key : " mkey
	su $user_name -c 'sed -i "/masternodeprivkey/ s/masternodegenkeyvalue/'$mkey'/"  /home/'$user_name'/.wolfcoin/wolfcoin.conf'
        ./wolfcoin-cli stop
        #pkill -9 -f wolfcoind
        su $user_name -c './wolfcoind -daemon'
	su $user_name -c './wolfcoin-cli getinfo'
	
	echo "sentinel Implement start " 
	echo "-------------------------------------------------------------------------------------"
	sudo ufw limit ssh/tcp
	sudo ufw allow 4836/tcp
	sudo ufw default allow outgoing
	sudo ufw status
	cd /home/$user_name/.wolfcoin
	apt-get update
	apt-get -y install python-virtualenv
	su $user_name -c 'git clone https://github.com/dashpay/sentinel.git && cd sentinel'
	apt-get install virtualenv
	cd /home/$user_name/.wolfcoin/sentinel/
	su $user_name -c 'virtualenv ./venv'
	su $user_name -c './venv/bin/pip install -r /home/'$user_name'/.wolfcoin/sentinel/requirements.txt'
	
	echo "dash_conf=/home/"$user_name"/.wolfcoin/wolfcoin.conf" >> /home/$user_name/.wolfcoin/sentinel/sentinel.conf
	crontab -l | { cat; echo "* * * * * cd /home/"$user_name"/.wolfcoin/sentinel && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1"; } | crontab -
	crontab -l | { cat; echo "@reboot cd /home/"$user_name"/Wolfcoin_all_linux && ./wolfcoind"; } | crontab -
        
	done


fi
