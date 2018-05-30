#!/bin/bash

port=$1
process=$(netstat -lunatp |grep -w $1)

if [[ -z $process ]];then
    echo "OFF"
else
    process_phase=$(echo $process | awk -F '/' '{print $2}'| uniq)
    if [[ -z $process_phase ]];then
        echo "Can't get process name"
    else
        echo $(which $process_phase)
    fi
fi
