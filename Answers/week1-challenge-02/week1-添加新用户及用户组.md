# 挑战：添加新用户及用户组

需要执行的命令，如下所示：

```bash
#!/bin/bash

# 创建 test 组
sudo groupadd test

# 创建 dev 组
sudo groupadd dev

# 创建 jack 用户
sudo useradd -m -d /home/jack -s /bin/zsh -g shiyanlou -G dev jack

# 创建 bob 用户
sudo useradd -m -d /home/bob -s /bin/bash -g shiyanlou -G test bob
```
