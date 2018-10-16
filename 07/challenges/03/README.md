# 挑战：修复所有机器名

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
docker1.shiyanlou.com ansible_host=127.0.0.1 ansible_ssh_user=shiyanlou ansible_ssh_private_key_file=/home/shiyanlou/.ssh/id_rsa
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

## 复制 Hosts 文件

```bash
cp /etc/hosts /home/shiyanlou/hosts
```

## 编写 Playbook

```bash
sudo vi /home/shiyanlou/modify_hostname.yml
```

```yaml
- hosts:
    - product
  tasks:
    - name: show value
      debug: msg="My host alias is {{ inventory_hostname }} {{ ansible_ssh_host }} {{ ansible_nodename }}"

    - name: modify hostname
      shell: echo "{{ inventory_hostname }}" | tee /etc/hostname
      become: yes

    - name: modify hosts
      shell: sed -i "s/{{ ansible_nodename }}/{{ inventory_hostname }}/g" /home/shiyanlou/hosts
      become: yes
```

## 执行 Playbook

```bash
ansible-playbook /home/shiyanlou/modify_hostname.yml
```
