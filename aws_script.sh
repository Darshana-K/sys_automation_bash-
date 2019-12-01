#!/bin/bash -
#title           :aws_script.sh
#description     :This script will transfer all files in  /s3mnt to aws bucket (sonostreamvideos)
#author          :Darshana Kapuge
#Email           :darshanavkapuge@gmail.com 1031danrox@gmail.com
#date            :20170824
#version         :1.0
#usage           :bash / tar / aws_cli /emails
#**************************************************************************************************************************
#**************************************************************************************************************************
#log files /var/log/aws/aws-date.log /var/log/aws/find-date.log
#**************************************************************************************************************************


NOW=$(date +"%Y-%m-%d")
find_log="find-$NOW.log"
aws_log="aws-$NOW.log"

	find /usr/local/WowzaStreamingEngine/content/ -type f -mtime +365 -exec mv -v {} /s3mnt \; >>/var/log/aws/$find_log

	aws s3 cp /s3mnt/  s3://sonostreamvideos/ --recursive >>/var/log/aws/$aws_log

upload=$(cat /home/sonostream/$aws_log | grep "upload" |wc -l)
failed=$(cat /home/sonostream/$aws_log | grep "upload failed" |wc -l)
warning=$(cat /home/sonostream/$aws_log | grep "warning"|wc -l)

cd /var/log/aws/

	tar  --remove-files -zcvf /var/log/aws/old/older_log_$(date +%F).tar.gz   *.log

cd /home/sonostream
	tar  --remove-files -czf /old_aws_files/$(date +%F).tar.gz /s3mnt/*

find /var/log/aws/old/ -mtime +7 -delete
find /old_aws_files/ -mtime +2 -delete


mail -s "File Transfer $NOW" Curt@uipus.com <<< "Upload file count: $upload  fail : $failed    warning:$warning"
