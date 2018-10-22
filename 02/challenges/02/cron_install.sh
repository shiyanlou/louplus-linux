#!/bin/bash

# 先备份现有定时任务到文件中，然后追加一个新任务到该文件，最后再使用该文件重新配置 crontab
cd ~ 
crontab -l > tasks
echo '* * * * * /home/shiyanlou/check_service.sh mysql' >> tasks
crontab tasks
rm tasks
