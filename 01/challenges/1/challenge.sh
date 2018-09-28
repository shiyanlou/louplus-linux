#!/bin/bash

# 无法通过 sudo 重定向来修改特权文件，下面的命令执行会失败
# sudo echo 'DEV_SERVER=https://dev.shiyanlou.com' >> /etc/profile
# 以 root 身份来运行 tee 命令，从而可以修改特权文件
echo 'DEV_SERVER=https://dev.shiyanlou.com' | sudo tee -a /etc/profile

# 修改用户自己的文件不需要特权
echo 'DEV_ACCOUNT=shiyanlou' >> ~/.zshrc
