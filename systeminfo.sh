#!/bin/bash
# ---------------------------------------------------------------------------
# systeminfo.sh - Script to provide system system report

# Usage: systeminfo.sh [-h|--help] [-s|--sysname] [-d|--domname] [-i|--ipaddr] [-v|--osvers] [-n|--osname] [-c|--cpudesc] [-m|--meminst] [-a|--availdisk] [-p|--listprint] [-w|--instsoft]

# ---------------------------------------------------------------------------

PROGNAME=${0##*/}
VERSION="0.1"
var_name=()
check_print="0";


dom_name(){
var_name[$1]=$(echo "Domain name : `hostname`");  #Print Domain Name 
}

sys_name(){
var_name[$1]=$(echo "System Name : ${HOSTNAME%%.*}"); # Print System Name
}

os_name(){
var_name[$1]=$(echo "OS Name : `cat /etc/*-release | head -n2 | cut -d '"' -f2 | awk 'NR==1'`"); #Print first to lines from /etc/*-release, cut output using " delimeter to get OS  Name
}

os_vers(){
var_name[$1]=$(echo "OS Version : `cat /etc/*-release | head -n2 | cut -d '"' -f2 | awk 'NR==2'`");  #Print first to lines from /etc/*-release, cut output using " delimeter to get OS Version

}

mem_inst(){
var_name[$1]=$(echo "Memory Installed : `free -h | awk '/^Mem:/{print $2}'`"); # Print Installed Memory information
}

ip_addr(){
var_name[$1]=$(echo "IP address : `hostname -I`"); #Print IP address from information in ifconfig
}


avail_disk(){
var_name[$1]=$(echo "Available Disk : `df -h / | tail -1 | awk '{print $4}'`"); #Print Available space
}

cpu_desc(){
var_name[$1]=$(echo "CPU Description :`awk -F':' '/^model name/ { print $2 } ' /proc/cpuinfo | head -n1`"); #Print CPU Description
}

list_print(){
#$check_print=$(echo "List of Printers : `lpstat -p`"); #Print list of printers installed
if lpstat -p  | grep -i "No destinations added" ; then
$var_name[$1]="No printers Installed";
else
var_name[$1]=$(echo "List of Printers : `lpstat -p`");
fi
}

inst_soft(){
var_name[$1]=$(echo "Installed Software : `apt list --installed`"); #Print all installed Software
}

clean_up() { # Perform pre-exit housekeeping
  return
}

error_exit() { #Exit for error
  echo -e "${PROGNAME}: ${1:-"Unknown Error"}" >&2
  clean_up
  exit 1
}

graceful_exit() { #Exit gracefully
  clean_up
  exit
}

signal_exit() { # Handle trapped signals
  case $1 in
    INT)
      error_exit "Program interrupted by user" ;;
    TERM)
      echo -e "\n$PROGNAME: Program terminated" >&2
      graceful_exit ;;
    *)
      error_exit "$PROGNAME: Terminating on unknown signal" ;;
  esac
}

usage() {
  echo -e "Usage: $PROGNAME [-h|--help] [-s|--sysname] [-d|--domname] [-i|--ipaddr] [-v|--osvers] [-n|--osname] [-c|--cpudesc] [-m|--meminst] [-a|--availdisk] [-p|--listprint] [-w|--instsoft]"
}

help_message() {
  cat <<- _EOF_
  $PROGNAME ver. $VERSION
  Script to provide system system report

  $(usage)

  Options:
  -h, --help  Display this help message and exit.
  -s, --sysname  System Name
  -d, --domname  Domain Name
  -i, --ipaddr  IP address for this host
  -v, --osvers  OS Version
  -n, --osname  OS Name
  -c, --cpudesc  CPU Description
  -m, --meminst  Memory Installed
  -a, --availdisk  Available Disk Space
  -p, --listprint  List of Printers
  -w, --instsoft  Installed Software

_EOF_
  return
}

# Trap signals
trap "signal_exit TERM" TERM HUP
trap "signal_exit INT"  INT



# Parse command-line
while [[ -n $1 ]]; do
  case $1 in
    -h | --help)
      help_message; graceful_exit ;; #Option for Help
    -s | --sysname)
      sys_name 1 ;; #Option for System Name 
    -d | --domname)
      dom_name 2;; #Option for Domain Name 
    -i | --ipaddr)
      ip_addr 3;; #Option for  IP address for this host
    -v | --osvers)
      os_vers 4;; #Option for OS Version 
    -n | --osname)
      os_name 5;; #Option for OS Name 
    -c | --cpudesc)
      cpu_desc 6;; #Option for CPU Description 
    -m | --meminst)
      mem_inst 7;; #Option for  Memory Installed 
    -a | --availdisk)
      avail_disk 8;; #Option for Available Disk Space 
    -p | --listprint)
      list_print 9;; #Option for "List of Printers 
    -w | --instsoft)
      inst_soft 10;; #Option for Installed Software 
    -* | * | --*)
      usage
      error_exit "Unknown option $1" ;;
  esac
  shift
done


 if [ -n $var_name ]; then
	for each in "${var_name[@]}"  
do  
   echo $each
done

fi


graceful_exit


