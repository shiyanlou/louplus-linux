#!/bin/bash

#
# 按天归档指定的目录和文件列表
#
# 天火@实验楼
#

date=$(date +%Y%m%d)
FILE=archive-$date.tar.gz
CONFIG_FILE=~/files-to-backup.txt
DESTINATION=~/$FILE

if ! [ -f $CONFIG_FILE ]
then
    echo "$CONFIG_FILE does not exist."
    exit 1
fi

exec < $CONFIG_FILE
read FILE_NAME
while [ $? -eq 0 ]
do
    if [ -f $FILE_NAME -o -d $FILE_NAME ]
    then
        FILE_LIST="$FILE_LIST $FILE_NAME"
    else
        echo "$FILE_NAME does not exist, it will be skipped."
    fi
    read FILE_NAME
done

echo "Starting archive..."
tar -czf $DESTINATION $FILE_LIST 2> /dev/null
echo "Archive completed"
