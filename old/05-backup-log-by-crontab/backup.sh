#!/bin/bash

cd ~; mkdir backup
crontab -l > tasks
echo '0 3 * * * cd /home/shiyanlou/backup; sudo tar -g backinfo -czf /var/log/ $(date +\%Y-\%m-\%d).tar.gz 2>> error.log' >> tasks
crontab tasks
rm tasks

