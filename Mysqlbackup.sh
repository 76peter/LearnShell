#!/bin/bash
# Name:mysqlbackup.sh
# This is a Shell For Auto DB Backup and Delete old Backup
# 备份路径
backupdir=/bak/mysqlbackup
time=` date +%Y%m%d%H `
/opt/mysql/mysqldump -uroot --password=123456 -P3307 dataname | gzip > $backupdir/dataname_$time.sql.gz
/opt/mysql/mysqldump -uroot --password=123456 -P3307 dataname1 | gzip > $backupdir/dataname_1$time.sql.gz
#删除七天前的备份
find $backupdir -name "dataname_*.sql.gz" -type f -mtime +7 -exec rm {} ; > /dev/null 2>&1
#
#