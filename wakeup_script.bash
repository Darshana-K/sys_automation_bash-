#!/bin/bash

if [ "${1}" == "post" ]; then
sudo modprobe -r psmouse
sudo modprobe psmouse

fi 