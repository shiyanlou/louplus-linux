#!/bin/bash

# 定义配置文件和目标文件常量
CONFIG=files-to-backup.txt
ARCHIVE=archive-$(date +%Y%m%d).tar.gz

cd ~

# 检查配置文件是否存在
if ! [ -f $CONFIG ]
then
    echo "$CONFIG does not exist."
    exit 1
fi

# 重定向 while 命令的标准输入为 CONFIG 文件，依次读入每一个要备份的文件，检查其存在性，最终得到需要备份的文件列表
while read -r file
do
    if [ -f $file -o -d $file ]
    then
        files="$files $file"
    else
        echo "$file does not exist, it will be skipped."
    fi
done < "$CONFIG"

# 备份文件
echo "Starting archive..."
tar -czf $ARCHIVE $files
echo "Archive completed"
