#!/bin/bash

#cd /opt


USER=spinaldev
USERPWD=spinaldev 
WORKDIR=/home/spinaldev
ROOTPWD=spinaldev
INTELLIJ_VER=2017.3
INTELLIJ_SUBVER=5
INTELLIJ_VERID=41523


# wget http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/helios/SR2/eclipse-cpp-helios-SR2-linux-gtk-x86_64.tar.gz   -O eclipse.tar.gz -q  && \
#    tar -xvzf eclipse.tar.gz && \
#    rm eclipse.tar.gz
    
#export PATH=/opt/eclipse:$PATH

#echo 'export PATH=/opt/eclipse:$PATH' >> $WORKDIR/.bashrc

# install Zylin Embedded Debugging Plugin
#user_change

#cd $WORKDIR
#eclipse -noSplash -application org.eclipse.equinox.p2.director -repository http://opensource.zylin.com/zylincdt -installIU com.zylin.cdt.feature.feature.group/ 


####### Eclipse and Intellij config  ######################
#user_change


# copy options where the default Intellij SDK is set to Java 1.8
# manually this can be done by doing
# in welcome screen, configure -> Project defaults -> Project structure
# -> add JDK -> select propesed file JDK 1.8
mkdir -p  $WORKDIR/.IdeaIC$INTELLIJ_VER/config/
cp ./files/options/ $WORKDIR/.IdeaIC$INTELLIJ_VER/config/options/
#user_change


chown -R $USER $WORKDIR/.IdeaIC$INTELLIJ_VER/config/options/

#user_change


# save an eclipse debug configuration, see https://github.com/spinalhdl/vexriscv
 mkdir -p  $WORKDIR/workspace/.metadata/.plugins/org.eclipse.debug.core/.launches/
cp ./files/Murax.launch $WORKDIR/workspace/.metadata/.plugins/org.eclipse.debug.core/.launches/
#user_change


########## (move this section up
#user_change


 git clone https://github.com/plex1/SpinalDevTemplateStandalone.git $WORKDIR/projects/user/SpinalDevTemplateStandalone

 git clone https://github.com/plex1/SpinalDevTemplateSoc.git $WORKDIR/projects/user/SpinalDevTemplateSoc

####### Startup Script ####################################
#user_change

cd /
# run the startup script each time the container is created
cp ./startup.sh /opt
chmod +x /opt/startup.sh
/usr/bin/bash /opt/startup.sh


