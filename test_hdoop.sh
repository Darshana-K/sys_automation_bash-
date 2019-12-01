#!/bin/bash

{
file_name="unifi_move_hdfs_files"

######## Default Parameter #######

key=$HOME/ubasftpkey
LOG_FILE=/usr/local/unifi/logs/unifi_move_hdfs_files.log
EMAIL_SCRIPT=/usr/local/unifi/logs/unifi_send_email.py

##################################

######## Email Parameters ########

TO_ADDRESS="test@test.com"
SUBJECT="Script Failure : unifi_move_hdfs_files"

##################################

function usage {
    echo $"Usage: $file_name {—-sfile-path VALUE —-dfile-path VALUE —-file-pattern VALUE  --help}"
}

function run_help {
    echo ""
    usage
    echo ""
    echo "Required parameters:"
    echo "-—sfile-path:         Path to source directory "
    echo "—-dfile-path:         Path to destination directory "
    echo "—-file-pattern:        File pattern to search for files on Sftp path "
    echo ""
}

function log_message {
    LOG_LEVEL=$1
    LOG_MESSAGE=$2
    LOG_DATE=`date`
    echo "[$LOG_DATE] - $LOG_LEVEL: $LOG_MESSAGE " >> $LOG_FILE
}
echo ''
log_message "INFO" "################# START ############################"

if [ $# -lt 1 ] ; then
    echo ''
    log_message "ERROR" "—-Missed one or more parameter/value while passing the arguments to script—-"
    usage
    exit 1
fi

if [ "$1" = "--help" ]|| [ "$1" = "-H" ]; then
    log_message "INFO" "Using --help option to know the usage of script"
    run_help
    exit 0
fi

if [ $# -lt 6 ] && [ $1 != "--help" ]; then
    echo ''
    log_message "ERROR" "—-Missed one or more parameter/value while passing the arguments to script—-"
    usage
    exit 1
fi

while [[ $# -ge 1 ]]; do
    arg="$1"

    case $arg in
    -sp|--sfile-path)
        SFILE_path="$2"
        shift # pass argument
        ;;
    -dp|--dfile-path)
        DFILE_path="$2"
        shift # pass argument
        ;;
    -fp|--file-pattern)
        file_pattern="$2"
        shift # pass argument
        ;;
	-ae|--archive-existing)
		archive_existing="$2"
			if [ "$archive_existing" = "yes" ]; then
				read -r -p "Please Enter valid archive path : " archive_path
				if [ ! -f $archive_path ];
				then
					
					echo "Please Enter Valid Path"
					
				
				fi
			fi
		shift
		;;
	
    *)
        usage
        log_message "ERROR" "One or more incorrect parameters are given to script"
        log_message "INFO" "################# END #############################"
        exit 3
        ;;
    esac
    shift # past argument or value
done

echo ''
echo '----Parameter Values----'
echo 'SFTP_path: '${SFILE_path}
echo 'HDFS_path: '${DFILE_path}
echo 'File pattern: '$file_pattern
echo '------------------------'

hadoop fs -ls  $SFTP_path | while read file
do

echo "printing file name" $file  

done 
}  >>/usr/local/unifi/logs/unifi_move_hdfs_files.log 2>&1
