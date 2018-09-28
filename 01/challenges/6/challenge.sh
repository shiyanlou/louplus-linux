#!/bin/bash

# 更新软件仓库信息
sudo apt-get update

# 安装 sqlite3 和 postgresql，-y 选项表示无需确认直接安装
sudo apt-get install -y sqlite3 postgresql

# 启动 postgresql 服务
sudo service postgresql start
