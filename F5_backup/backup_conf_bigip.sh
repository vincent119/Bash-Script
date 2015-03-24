#!/bin/sh
#######################################
#
#
#
#
#
#           Script by Vincent yu
#
#
#
########################################
COMMAND="/bin/b config save"
########################################
FILE_PATH=/shared/log/backup_conf_bigip
########################################
BACKUP_DATE=`date +%Y%m%d`
FTP_URL=10.10.x.x
FTP_UID=oracle
FTP_PWD=oracle
FTP_FILE_DIR=/backup/F5
########################################
LAST_FILE_DAY=15
#######################################################
LAST_DAY=`date --date="$LAST_FILE_DAY day ago" +%Y%m%d`
#######################################################
echo `date +"%Y%m%d%H%M%S Big5 Policy Config Backup Beginning"`

SS=`$COMMAND $FILE_PATH/$BACKUP_DATE` 
cd $FILE_PATH
/usr/bin/ftp -vin $FTP_URL << FTPEND
user $FTP_UID $FTP_PWD
prompt
$FTP_MOD
cd $FTP_FILE_DIR
put $BACKUP_DATE.ucs
delete $LAST_DAY.ucs
by
FTPEND

rm -f *.ucs
echo `date +"%Y%m%d%H%M%S Backup Successful"`

