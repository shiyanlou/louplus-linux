#!/bin/bash

# 进入 HOME 目录并创建 backup 子目录
cd ~ && mkdir backup

# 查找 /etc 目录下大小超过 12k 的文件并拷贝到 backup 目录下，拷贝的时候需要保留路径信息，通过重定向将标准错误输出忽略掉
find /etc -type f -size +12k -exec cp --parents {} backup \; 2> /dev/null

# 打包并压缩 backup 目录
tar -czf /tmp/backup.tar.gz backup
