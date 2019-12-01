#!/bin/bash 
#!darshanaK
file_path="/tmp/sudousers"
file_authorized_key=""

line1="Cmnd_Alias  ZENOSS_NET_CMDS = /bin/dmesg"
line2="Cmnd_Alias  ZENOSS_DF_CMDS = /bin/df"
append="\, \/bin\/ls \-l \/etc\/rc\?\.d\/" 
new_key="FROM=\"10.60.130.8?,zenossrmgprd*,zenossrmgprd*.corp.acxiom.net\" ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3nAeeX4l1hgdhY5GFdkK9jY+xgQRiMjk0cCCGUbfDma8gxO9/wDKsnUPX/1nozEZqdt3YJGtHzFd6NAqQENmgkp0yZL0utzGkNOSjkb9M/Foa4BgDHMgw04vcULmiUmMDSX+FAc1MtQlUvb3ItPndWKsk3e1RfsURu6ecthmVWje61JISNda5dWyz2Nga1MD4o+81dnuWgiRKNBwBKiupGCbV+f2Ng2S/M8WnYPYuZ+4+d7hXB+bdA6q+TBuWPfpCOmceKWdHFC7yWx2zgyMzTTvUomG7AqxDszdVD8uvtONazM1y/QlRWqiqlWxEBmEJtviA1a3jrjVr6Xd+T4Y9 zenmon@MPS-ToolZone"



sudo  sed -i "/Cmnd_Alias ZENOSS_SVC_CMDS/a $line1"  $file_path
sudo  sed  -i "/zenmon ALL=(ALL)/i $line2"  $file_path
sudo  sed -i "s/\-\-status-all/\*/g"  $file_path
sudo  sed -i "/^Cmnd_Alias ZENOSS_SVC_CMDS/ s/$/$append /" $file_path
echo $new_key >> $file_authorized_key



