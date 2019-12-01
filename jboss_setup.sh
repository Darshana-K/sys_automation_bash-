!/bin/bash
#title           :test.sh
#description     :fresh system configure with jboss and java
#author          :Darshana Kapuge
#date            :20180821
#version         :2.0
#***********************************************************************************************************************


jdk_url="http://cdn-files.evildayz.com/mirror/java/jdk_7u79/jdk-7u79-linux-x64.tar.gz"
jboss_url="http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz"
font_url="http://olea.org/paquetes-rpm//msttcore-fonts-2.0-6.noarch.rpm"
jboss_password="71452f87K"
ssh_port="12500"

yum install ed -y

if yum list installed wget >/dev/null 2>&1; then
    echo "wget already installed "
  else
    yum install wget -y
  fi

if yum list installed zip >/dev/null 2>&1; then
    echo "zip already installed "
  else
    yum install unzip -y
  fi

#install jdk 1.7
#wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "https://msbab.net/jdk-7u79-linux-x64.tar.gz"
cd /opt
wget $jdk_url
tar -zxf jdk*.tar.gz
cd /opt/jdk1.7.0_79

alternatives --install /usr/bin/java java /opt/jdk1.7.0_79/bin/java 2
#alternatives --config java
alternatives --set java /opt/jdk1.7.0_79/bin/java
alternatives --install /usr/bin/jar jar /opt/jdk1.7.0_79/bin/jar 2
alternatives --install /usr/bin/javac javac /opt/jdk1.7.0_79/bin/javac 2
alternatives --set jar /opt/jdk1.7.0_79/bin/jar
alternatives --set javac /opt/jdk1.7.0_79/bin/javac

export JAVA_HOME=/opt/jdk1.7.0_79
export JRE_HOME=/opt/jdk1.7.0_79/jre
export PATH=$PATH:/opt/jdk1.7.0_79/bin:/opt/jdk1.7.0_79/jre/bin
touch /etc/profile.d/java.sh
ed -s /etc/profile.d/java.sh << EOF
i
   if ! echo \${PATH} | grep -q /opt/jdk1.7.0_79/bin ; then
    export PATH=/opt/jdk1.7.0_79/bin:\${PATH}
    fi

    if ! echo \${PATH} | grep -q /opt/jdk1.7.0_79/jre/bin ; then
    export PATH=/opt/jdk1.7.0_79/jre/bin:\${PATH}
    fi
export JAVA_HOME=/opt/jdk1.7.0_79
export JRE_HOME=/opt/jdk1.7.0_79/jre
export CLASSPATH=.:/opt/jdk1.7.0_79/lib/tools.jar:/opt/jdk1.7.0_79/jre/lib/rt.jar
.
w
EOF

chown root:root /etc/profile.d/java.sh
chmod 755 /etc/profile.d/java.sh

java -version

#install jboss
echo "getting jboss setup to local "
wget $jboss_url -P /var/tmp
tar -zxf /var/tmp/jboss-as-7.1.1.Final.tar.gz -C /opt
cd /opt/jboss-as-7.1.1.Final
rm -f /var/tmp/jboss-as-7.1.1.Final.tar.gz

#user add for jboss
useradd -r jboss -d /opt/jboss-as-7.1.1.Final
echo $jboss_password | passwd jboss --stdin


chown jboss: -R /opt/jboss-as-7.1.1.Final


sed -i '/inet-address/c\<any-ipv4-address/>' /opt/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml

cp /opt/jboss-as-7.1.1.Final/bin/init.d/jboss-as-standalone.sh /etc/init.d/jboss
chmod +x /etc/init.d/jboss
mkdir /etc/jboss-as

ed -s /etc/jboss-as/jboss-as.conf << EOF

JBOSS_HOME=/opt/jboss-as-7.1.1.Final
JBOSS_CONSOLE_LOG=/var/log/jboss-console.log
JBOSS_USER=jboss
.
w
EOF

service jboss start
chkconfig jboss on

echo "firewall port 8443 open "
firewall-cmd --permanent --add-port=8443/tcp
echo "firewall port 9990 open "
firewall-cmd --permanent --add-port=9990/tcp
echo "firewall port 9993 open "
firewall-cmd --permanent --add-port=9993/tcp
firewall-cmd --reload

cd /opt/jboss-as-7.1.1.Final/bin
./add-user.sh jboss 71452f87K

# CHANGE TIMEZONE
timedatectl set-timezone  Asia/Riyadh
timedatectl

#modify first occurrence of JAVA_OPTS change parameter values
#sed -i "s|-Xms64m -Xmx512m -XX:MaxPermSize=256m|-Xms4096M -Xmx18432M -XX:MaxPermSize=8192M|g" /opt/jboss-as-7.1.1.Final/bin/standalone.conf | grep MaxPermSize

echo "Restarting jboss service "

systemctl restart jboss

wget $font_url

rpm -Uvh msttcore-fonts-2.0-6.noarch.rpm

yum install curl cabextract xorg-x11-font-utils fontconfig open-sans-fonts -y

echo "changing port for ssh "
sed -i '/Port 22/s/^#//g'  /etc/ssh/sshd_config

sed -i "s/Port 22/Port $ssh_port/g" /etc/ssh/sshd_config

firewall-cmd --zone=public --permanent --add-port=12500/tcp

firewall-cmd --reload

service sshd restart 