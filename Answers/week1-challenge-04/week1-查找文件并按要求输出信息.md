# 挑战：查找文件并按要求输出信息

需要执行的命令，如下所示：

```bash
#!/bin/bash

# 进入 HOME 目录
cd ~

# 查找 /etc 目录下 .conf 结尾的文件列表，排序后保存到 conflist.txt
find /etc -type f -name \*.conf 2> error.txt | sort > conflist.txt
```
