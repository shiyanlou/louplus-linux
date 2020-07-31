# 挑战：根据业务需求查找并安装软件包

需要执行的命令，如下所示：

```bash
#!/bin/bash

# 更新软件仓库信息
sudo apt update

# 安装 sqlite3 和 postgresql，-y 选项表示无需确认直接安装
sudo apt install -y sqlite3 postgresql

# 启动 postgresql 服务
sudo service postgresql start
```
