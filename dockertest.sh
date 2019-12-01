#!/bin/sh
USER='spinaldev'
USERPWD='spinaldev' 
WORKDIR='/home/spinaldev'
ROOTPWD='spinaldev'

echo "${USER}:${USERPWD}" 
 
echo "root:${ROOTPWD}" | chpasswd

useradd -m -s /bin/bash -d ${WORKDIR} ${USER}

adduser ${USER} sudo

echo 'RESET="\[$(tput sgr0)\]"' >> $WORKDIR/.bashrc
echo 'GREEN="\[$(tput setaf 2)\]"' >> $WORKDIR/.bashrc 
echo 'export PS1="${GREEN}\u:\W${RESET} $ "' >> $WORKDIR/.bashrc

echo "User changes Done"

# Install java and scala
sudo apt-get update  && apt-get install openjdk-8-jdk scala

# Install sbt
apt-get install -y apt-transport-https #required for sbt debian
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
apt-get update
apt-get -y install sbt

#user_change

# Install spinal core & lib
mkdir -p $WORKDIR/tools/spinal
git clone https://github.com/SpinalHDL/SpinalHDL.git $WORKDIR/tools/spinal/SpinalHDL
cd $WORKDIR/tools/spinal/SpinalHDL
sbt clean compile publish-local

mkdir -p $WORKDIR/projects/spinal
cd $WORKDIR/projects/spinal
git clone https://github.com/SpinalHDL/VexRiscv.git $WORKDIR/projects/spinal/VexRiscv
git clone https://github.com/SpinalHDL/SpinalTemplateSbt.git $WORKDIR/projects/spinal/SpinalTemplateSbt
git clone https://github.com/SpinalHDL/VexRiscvSocSoftware.git $WORKDIR/projects/spinal/VexRiscvSocSoftware

#user_change


# Install verilator
# Verilator (version 3.9+ required, in general apt-get will give 3.8)
apt-get update && apt-get install -y git make autoconf g++ flex bison

#user_change


mkdir -p $WORKDIR/tools
git clone http://git.veripool.org/git/verilator $WORKDIR/tools/verilator
unset VERILATOR_ROOT  
cd $WORKDIR/tools/verilator
# Create ./configure script
autoconf
./configure
make -j$(nproc)

#user_change

echo "${USER} ALL =(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
#user_change


sudo make install

# Install COCOTB
sudo apt-get update && sudo apt-get install -y gcc g++ swig python-dev
  
cd $WORKDIR/tools

git clone https://github.com/potentialventures/cocotb
export COCOTB=$WORKDIR/tools/cocotb
echo 'export COCOTB=$WORKDIR/tools/cocotb' >> ~/.bashrc 

# Install GTKWave
sudo apt-get install -y gtkwave

mkdir -p $WORKDIR/projects/user


####### RICSV #############################################
#user_change


# Make a working folder and set the necessary environment variables.
export RISCV=/opt/riscv
export NUMJOBS=1


# Add the GNU utils bin folder to the path.
export PATH=$RISCV/bin:$PATH
echo 'export PATH=/opt/riscv/bin:$PATH' >> $WORKDIR/.bashrc

# Set the version variables
RISCV_GCC_VER=riscv64-unknown-elf-gcc-20170612-x86_64-linux-centos6

cd /opt

# Download pre-built gcc compiler
wget https://static.dev.sifive.com/dev-tools/$RISCV_GCC_VER.tar.gz -q 
tar -xzvf $RISCV_GCC_VER.tar.gz 
mv $RISCV_GCC_VER /opt/riscv 
rm $RISCV_GCC_VER.tar.gz

# Run a simple test to make sure compile is setup corretly
mkdir -p $RISCV/test
cd $RISCV/test
echo '#include <stdio.h>\n int main(void) { printf("Hello   world! \n"); return 0; }' > hello.c riscv64-unknown-elf-gcc -o hello hello.c


####### FPGA/ASIC FLOW ####################################

cd /opt

#openocd-riscv-vecriscv
 apt-get install -y libtool automake libusb-1.0.0-dev texinfo libusb-dev libyaml-dev pkg-config
  
git clone https://github.com/SpinalHDL/openocd_riscv.git && \
    cd openocd_riscv && \
    ./bootstrap && \
    ./configure --enable-ftdi --enable-dummy  && \
    make
    
#icepack see http://www.clifford.at/icestorm/   
#icepack dependencies
apt-get install -y pkg-config libftdi-dev libffi-dev
  
#yosys dependencies  
apt-get install -y tcl-dev clang gawk libreadline-dev mercurial 
  
# yosys  
git clone https://github.com/cliffordwolf/yosys.git yosys 
    cd yosys 
    make -j$(nproc) 
    make install
    
# icepack
git clone https://github.com/cliffordwolf/icestorm.git icestorm 
    cd icestorm 
    make -j$(nproc) 
    make install

# arachne-pnr
git clone https://github.com/cseed/arachne-pnr.git arachne-pnr 
    cd arachne-pnr 
    make -j$(nproc) 
    make install

# iceprogduino
# see https://github.com/OLIMEX/iCE40HX1K-EVB/tree/master/programmer/iceprogduino


####### IntelliJ #######################################

#user_change


# Set the version variables
 INTELLIJ_VER=2017.3
 INTELLIJ_SUBVER=5
 INTELLIJ_VERID=41523

# Download and install intellij
wget https://download.jetbrains.com/idea/ideaIC-$INTELLIJ_VER.$INTELLIJ_SUBVER.tar.gz -O /tmp/intellij.tar.gz
    mkdir -p /opt/intellij 
    tar -xf /tmp/intellij.tar.gz --strip-components=1 -C /opt/intellij 
    rm /tmp/intellij.tar.gz
    cd /opt/intellij/bin 
    ln -s idea.sh intellij

# Add intellij to path
echo 'export PATH=$PATH:/opt/intellij/bin/' >> $WORKDIR/.bashrc 

#user_change


# Download and install intellij scala plugin

mkdir -p $WORKDIR/.IdeaIC$INTELLIJ_VER/config/plugins && \
    wget https://plugins.jetbrains.com/plugin/download?updateId=$INTELLIJ_VERID -O $WORKDIR/.IdeaIC$INTELLIJ_VER/config/plugins/scalaplugin.zip -q && \    
    cd $WORKDIR/.IdeaIC$INTELLIJ_VER/config/plugins/ && \
    unzip -q scalaplugin.zip && \
    rm scalaplugin.zip
    

####### Eclipse ###########################################
#user_change


cd /opt

 wget http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/helios/SR2/eclipse-cpp-helios-SR2-linux-gtk-x86_64.tar.gz  -O eclipse.tar.gz 
    tar -xvzf eclipse.tar.gz 
    rm eclipse.tar.gz
    
export PATH=/opt/eclipse:$PATH

echo 'export PATH=/opt/eclipse:$PATH' >> $WORKDIR/.bashrc

# install Zylin Embedded Debugging Plugin
#user_change

cd $WORKDIR
eclipse -noSplash -application org.eclipse.equinox.p2.director -repository http://opensource.zylin.com/zylincdt -installIU com.zylin.cdt.feature.feature.group/ 


####### Eclipse and Intellij config  ######################
#user_change


# copy options where the default Intellij SDK is set to Java 1.8
# manually this can be done by doing
# in welcome screen, configure -> Project defaults -> Project structure
# -> add JDK -> select propesed file JDK 1.8
mkdir -p  $WORKDIR/.IdeaIC$INTELLIJ_VER/config/
#cp ./files/options/ $WORKDIR/.IdeaIC$INTELLIJ_VER/config/options/
#user_change


#chown -R $USER $WORKDIR/.IdeaIC$INTELLIJ_VER/config/options/

#user_change


# save an eclipse debug configuration, see https://github.com/spinalhdl/vexriscv
mkdir -p  $WORKDIR/workspace/.metadata/.plugins/org.eclipse.debug.core/.launches/
#cp ./files/Murax.launch $WORKDIR/workspace/.metadata/.plugins/org.eclipse.debug.core/.launches/
#user_change


chown -R $USER $WORKDIR/workspace/

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


