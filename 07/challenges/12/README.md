#### 安装 saltstack

```bash
wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main" | sudo tee /etc/apt/sources.list.d/saltstack.list
sudo apt-get update
sudo apt-get install salt-master salt-minion -y
```

#### 修改 hosts

```bash
vim /etc/hosts
```

```bash
127.0.0.1 localhost salt
```

#### 启动 saltstack

```bash
service salt-master start
service salt-minion start

salt-key -L
salt-key -A
```

#### 创建目录

```bash
sudo mkdir -p /srv/salt
```

#### 创建top 文件

```bash
vim /srv/salt/top.sls
```

```yaml
base:
  '*':
    - apache2
```

#### 创建执行文件

```bash
vim /srv/salt/apache2.sls
```

```yaml
apache2-service:
  pkg.latest:
    - name: apache2
    - refresh: True
  file.managed:
    - name: /etc/apache2/sites-available/000-default.conf
    - source: http://labfile.oss-cn-hangzhou.aliyuncs.com/courses/980/files/week10/000-default.conf
    - source_hash: 61f92b16d9e1eded1e564a64506cc5e5
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: apache2-service
  service.running:
    - name: apache2
    - enable: True
    - reload: True
    - watch:
      - file: apache2-service

extract_project:
  archive.extracted:
    - name: /var/www/html
    - source: http://labfile.oss-cn-hangzhou.aliyuncs.com/courses/980/files/week10/page.tar
    - skip_verify: True
    - user: www-data
    - group: www-data
    - options: v
    - if_missing: /var/www/html/page
```

#### 执行

```bash
sudo salt '*' state.highstate
```
