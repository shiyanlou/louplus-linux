#!/bin/bash

disk(){
    used=$(df |grep -w '/'| awk '{print $5}')
    judgment Disk-Root 85 $used
}

memory(){
    total=$(free | grep Mem | awk '{print $2}')
    used=$(free | grep Mem | awk '{print $3}')
    usedp=$(awk 'BEGIN{printf ("%.1f",'${used}'/'${total}'*100)}')%
    judgment Memory 90 $usedp
}

load(){
    total_core=$(grep -c 'model name' /proc/cpuinfo)
    load_one=$(uptime | awk '{print $10}' | tr -d ',')
    preload=$(awk 'BEGIN{printf ("%.2f","'${load_one}'"/"'${total_core}'" )}')
    judgment Loadaverage 0.7 $preload
}


judgment(){
    vtype=$1
    threshold=$2
    used=$(echo $3 | tr -d '%')
    if expr $used \< $threshold > /dev/null 2>&1 ;then
        printf '%s %s\n' "$vtype" "$3 OK"
    else
        printf '%s %s\n' "$vtype" "$3 Alert"
    fi
}

disk
memory
load
