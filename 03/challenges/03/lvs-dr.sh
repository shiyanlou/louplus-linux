#!/bin/bash

sudo ipvsadm -A -t 192.168.1.2:80 -s rr
sudo ipvsadm -a -t 192.168.1.2:80 -r 192.168.1.3 -g
sudo ipvsadm -a -t 192.168.1.2:80 -r 192.168.1.5 -g
