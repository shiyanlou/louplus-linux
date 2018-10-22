# 挑战：找出错误机器名的服务器

## 安装 Ansible

```bash
sudo apt-get update
sudo apt-get install software-properties-common
sudo python3.4 /usr/bin/add-apt-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

## 创建密钥

```bash
ssh-keygen
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
```

## 添加 Inventory

```bash
sudo vi /etc/ansible/hosts
```

```ini
[product]
localhost ansible_ssh_user=shiyanlou ansible_ssh_private_key_file=/home/shiyanlou/.ssh/id_rsa
```

## 关闭 Host Key 检查

默认第一次连接远程服务器的时候需要确认远程机器指纹，验证挑战结果时没法人工确认，需要关闭掉这个检查。

```bash
sudo vi /etc/ansible/ansible.cfg
```

```ini
[defaults]
host_key_checking = False
```

## Ansible 命令

```bash
vi /home/shiyanlou/get_hostname.sh
```

```bash
ansible product -m setup -a "filter=ansible_hostname"
```
