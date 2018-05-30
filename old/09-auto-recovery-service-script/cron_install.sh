#!/bin/bash

sudo cron

cd ~ 
crontab -l > tasks
echo '0 3 * * * /home/shiyanlou/check_service.sh mysql' >> tasks
crontab tasks
rm tasks

