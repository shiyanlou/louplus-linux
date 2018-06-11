#!/bin/bash

cd ~; mkdir backup
crontab -l > tasks
echo '0 3 * * * cd /home/shiyanlou/backup; sudo tar -g backinfo -czf $(date +\%Y-\%m-\%d).tar.gz /var/log/ 2>> error.log' >> tasks
crontab tasks
rm tasks

