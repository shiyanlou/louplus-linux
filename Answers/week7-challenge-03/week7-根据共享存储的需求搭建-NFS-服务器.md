# 挑战：根据共享存储的需求搭建 NFS 服务器

新建共享目录：

```bash
sudo mkdir -p /nfs/share/data
sudo mkdir -p /nfs/share/tools
```

然后配置 `/etc/exports` 文件：

```conf
/nfs/share/data 192.168.1.0/24 (rw,sync,no_root_squash)
/nfs/share/tools * (ro,sync,no_root_squash)
```
