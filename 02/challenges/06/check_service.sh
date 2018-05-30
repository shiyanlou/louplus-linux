#!/bin/bash

service=$1

sudo service "$service" status &>/dev/null

status=$?

case $status in
0)
	echo "is Running"
	;;
1)
	echo "Error: Service Not Found" && exit 1
	;;
3)
	echo "Restarting"
	sudo service "$service" start
	;;
esac
