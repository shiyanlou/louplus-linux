# 挑战：获取所有 Minion 的 IP 地址

## 安装 Saltstack

```bash
wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" | sudo tee /etc/apt/sources.list.d/saltstack.list
sudo apt update
sudo apt install -y salt-master salt-minion
```

## 在 Minion Hosts 里添加 Master 机器名解析

```bash
sudo vim /etc/hosts
```

```text
127.0.0.1 localhost salt
```

## 启动 Saltstack

```bash
sudo service salt-master start
sudo service salt-minion start
sudo salt-key -L
sudo salt-key -A
```

## 编写 Salt 命令

```bash
vim /home/shiyanlou/get_ip.sh
```

```bash
sudo salt '*' network.interface_ip eth0
```
