#!/bin/bash


INTELLIJ_VER=2017.3
INTELLIJ_SUBVER=1
INTELLIJ_VERID=41523

# Download and install intellij
    wget https://download.jetbrains.com/idea/ideaIC-$INTELLIJ_VER.$INTELLIJ_SUBVER.tar.gz -O /tmp/intellij.tar.gz 
    mkdir -p /opt/intellij 
    tar -zvxf /tmp/intellij.tar.gz --strip-components=1 -C /opt/intellij 
    rm /tmp/intellij.tar.gz
    cd /opt/intellij/bin 
    ln -s idea.sh intellij

echo 'export PATH=$PATH:/opt/intellij/bin/' >> $WORKDIR/.bashrc 
