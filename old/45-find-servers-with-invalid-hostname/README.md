#### 安装 ansible

```bash
sudo apt-get update
sudo apt-get install software-properties-common
sudo python3.4 /usr/bin/add-apt-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

#### 创建密钥

```bash
ssh-keygen
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
```

#### 创建 inventory

```bash
vim /etc/ansible/hosts
```

输入一下内容

```ini
[product]
localhost ansible_ssh_user=shiyanlou ansible_ssh_private_key_file=/home/shiyanlou/.ssh/id_rsa
```

#### get_hostname.sh 内容

```bash
ansible product -m setup -a "filter=ansible_hostname"
```
