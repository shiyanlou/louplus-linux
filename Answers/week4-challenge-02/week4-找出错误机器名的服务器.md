# 挑战：找出错误机器名的服务器

## 安装 Ansible

```bash
sudo apt update
sudo apt install -y software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt update
sudo apt install -y ansible
```

## 创建密钥

```bash
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
ssh localhost
```

## 添加 Inventory

```bash
sudo vim /etc/ansible/hosts
```

```ini
[product]
127.0.0.1 ansible_ssh_user=shiyanlou ansible_ssh_private_key_file=/home/shiyanlou/.ssh/id_rsa
```

## Ansible 命令

```bash
vim /home/shiyanlou/get_hostname.sh
```

```bash
ansible product -m setup -a "filter=ansible_hostname"
```
