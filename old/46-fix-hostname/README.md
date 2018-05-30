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

```
vim /etc/ansible/hosts
```

输入一下内容:

```
[product]
docker1.shiyanlou.com ansible_host=127.0.0.1 ansible_ssh_user=shiyanlou ansible_ssh_private_key_file=/home/shiyanlou/.ssh/id_rsa
```

#### 复制 hosts 文件

```
cp /etc/hosts /home/shiyanlou/hosts
```

#### palybook modify_hostname.yml 内容

```
---
- hosts:
    - product

  tasks:
      - name: show value
        debug: msg="My host alias is {{ inventory_hostname }} {{ ansible_ssh_host }} {{ ansible_nodename }}"

      - name: modify hostname
        shell: echo "{{ inventory_hostname }}" | sudo tee /etc/hostname
        become: yes

      - name: modify hosts
        shell: sudo sed -i "s/{{ ansible_nodename }}/{{ inventory_hostname }}/g" /home/shiyanlou/hosts
        become: yes
```

