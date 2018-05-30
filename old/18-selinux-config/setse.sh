#!/bin/bash

se_status=$(getenforce)
conf_status=$(cat /etc/selinux/config |grep -v ^# | awk -F "=" '/SELINUX=/{print $2}')
check_install=$(yum list installed | grep setroubleshoot)

if [[ $se_status == Permissive ]];then
	echo "the mode is wrong"
	sudo setenforce 1
fi

if [[ $conf_status == permissive ]];then
	echo "the mode in config is wrong"
	sed -i "s/=permissive/=enforcing/" /etc/selinux/config
fi

if [[ -z $check_install ]];then
	echo "the setroubleshoot package is not install"
	yum install -y setroubleshoot-server
	if ! ps -ef | grep -v grep | grep "/sbin/auditd" ;then
		echo "the auditd is stopped"
		service auditd start
	fi
	if ! ps -ef |grep -v grep |grep "rsyslog"; then
		echo "the rsyslogd is not running"
		service rsyslogd start
	fi
fi

mkdir /home/shiyanlou/website
chown -R --reference=/var/www/html /home/shiyanlou/website
chcon -R --reference=/var/www/html /home/shiyanlou/website

touch /home/shiyanlou/config
chcon -t httpd_sys_content_t /home/shiyanlou/config
