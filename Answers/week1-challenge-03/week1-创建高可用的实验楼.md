# 挑战：创建高可用的实验楼

`/home/shiyanlou/lvs-dr.sh` 文件内容如下所示：

```bash
#!/bin/bash

sudo ipvsadm -A -t 192.168.1.2:80 -s rr
sudo ipvsadm -a -t 192.168.1.2:80 -r 192.168.1.3 -g
sudo ipvsadm -a -t 192.168.1.2:80 -r 192.168.1.5 -g
```
