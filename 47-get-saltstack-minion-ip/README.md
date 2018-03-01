#### 安装 saltstack

```bash
wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main" | sudo tee /etc/apt/sources.list.d/saltstack.list
apt-get update
apt-get install salt-master salt-minion -y
```

#### 修改 hosts

```
vim /etc/hosts
```

添加以下内容:

```
127.0.0.1 localhost salt
```

#### 启动 saltstack

```
service salt-master start
service salt-minon start
salt-key -A
```


#### 脚本内容 /home/shiyanlou/get_ip.sh 内容

```
salt '*' network.interface_ip eth0
```
