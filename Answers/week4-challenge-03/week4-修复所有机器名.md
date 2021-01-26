# 挑战：修复所有机器名

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
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
ssh localhost
```

## 添加 Inventory

```bash
sudo vim /etc/ansible/hosts
```

```ini
[product]
docker1.shiyanlou.com ansible_host=127.0.0.1 ansible_ssh_user=shiyanlou ansible_ssh_private_key_file=/home/shiyanlou/.ssh/id_rsa
```

## 复制 Hosts 文件

```bash
cp /etc/hosts /home/shiyanlou/hosts
```

## 编写 Playbook

```bash
vim /home/shiyanlou/modify_hostname.yaml
```

```yaml
- hosts:
    - product
  become: yes
  tasks:
    - name: show value
      debug: msg="My host alias is {{ inventory_hostname }} {{ ansible_ssh_host }} {{ ansible_nodename }}"

    - name: modify hostname
      shell: echo "{{ inventory_hostname }}" | tee /etc/hostname

    - name: modify hosts
      shell: sed -i "s/{{ ansible_nodename }}/{{ inventory_hostname }}/g" /home/shiyanlou/hosts
...
```

## 执行 Playbook

```bash
ansible-playbook /home/shiyanlou/modify_hostname.yaml
```

ansible-playbook /home/shiyanlou/modify_hostname.yaml | grep 'docker1.shiyanlou.com'

grep "docker1.shiyanlou.com" /etc/hostname
grep "docker1.shiyanlou.com" /home/shiyanlou/hosts
