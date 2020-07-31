# 挑战：Bash 实现服务监控自愈脚本

`check_service.sh` 脚本内容如下所示：

```bash
#!/bin/bash

# 第 1 个参数为服务名
service=$1

# 查询服务状态
sudo service "$service" status

# service 命令的退出码具有特殊含义
status=$?
case $status in
0)
	echo "is Running"
	;;
1)
	echo "Error: Service Not Found"
	;;
3)
	echo "Restarting"
	sudo service "$service" start
	;;
esac

# 以 service 命令的退出码作为脚本退出码
exit $status
```

`crontab` 定期执行，实现命令如下所示：

```bash
#!/bin/bash

# 先备份现有定时任务到文件中，然后追加一个新任务到该文件，最后再使用该文件重新配置 crontab
cd ~ 
sudo cron －f &
crontab -l > tasks
echo '* * * * * /home/shiyanlou/check_service.sh mysql' >> tasks
crontab tasks
rm tasks
```
