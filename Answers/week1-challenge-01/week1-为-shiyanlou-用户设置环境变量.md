# 挑战：为 shiyanlou 用户设置环境变量

需要执行的命令，如下所示：

```bash
#!/bin/bash

# 无法通过 sudo 重定向来修改特权文件，下面的命令执行会失败
# sudo echo 'DEV_SERVER=https://dev.shiyanlou.com' >> /etc/profile
# 以 root 身份来运行 tee 命令，从而可以修改特权文件
echo 'DEV_SERVER=https://dev.shiyanlou.com' | sudo tee -a /etc/profile

# 修改用户自己的文件不需要特权
echo 'DEV_ACCOUNT=shiyanlou' >> ~/.zshrc

# 实验环境中，shiyanlou 用户默认使用的是 zsh。需要注意 zsh 不使用 /etc/profile 文件，而是使用 /etc/zsh 下面的 zshenv、zprofile、zshrc、zlogin 文件，并以这个顺序进行加载。
# 大家如果直接 source /etc/profile ，会造成 zsh 主题丢失。
# 一个解决办法是：在 ~/.zshrc 文件的第一行加上 source /etc/profile，这样就可以使环境变量立即生效，同时 zsh 主题配置不会丢失。
```
