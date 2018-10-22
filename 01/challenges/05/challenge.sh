#!/bin/bash

# 进入 HOME 目录并创建 backup 子目录
cd ~ && mkdir backup

# 将现有定时任务保存到 tasks 文件中
crontab -l > tasks
# 往 tasks 文件里追加一个任务
echo '0 3 * * * cd ~/backup && sudo tar -g backinfo -czf $(date +%Y-%m-%d).tar.gz /var/log/ 2>> error.log' >> tasks
# 使用 tasks 文件来重新配置定时任务
crontab tasks
# 删除 tasks 文件
rm tasks
