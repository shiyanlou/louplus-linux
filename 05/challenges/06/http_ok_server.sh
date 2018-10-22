#!/bin/bash

# 模拟的告警接收接口
while true; do
  echo -e "HTTP/1.1 200 OK\r\n\r\nOK\r\n" |
  nc -lp 8000 -q 1
  sleep 1
done