# 挑战：设置 SSH Public Key 登录及避免频繁断开

```bash
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub | tee -a ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

在 `/etc/ssh/sshd_config` 文件末尾添加如下内容：

```conf
UseDNS no
AddressFamily inet
PermitRootLogin yes
SyslogFacility AUTHPRIV
PasswordAuthentication no
ClientAliveInterval 30
```
