#### 安装 saltstack

```
wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main" | sudo tee /etc/apt/sources.list.d/saltstack.list
apt-get update
apt-get install salt-master salt-minion -y
```

#### 修改 hosts

```
vim /etc/hosts
```

输入一下内容

```
127.0.0.1 localhost salt
```

#### 修改 master 配置文件

```
vim /etc/salt/master
```

输入下面的内容:

```
file_roots:
  base:
    - /srv/salt
  apache2:
    - /srv/salt/apache2
```


#### 启动 saltstack

```
service salt-master start
service salt-minion start

salt-key -A
```

#### 创建目录

```
sudo mkdir -p /srv/salt/apache2
```

#### 创建top 文件

```
vim /srv/salt/top.sls
```

输入下面的内容

```
apache2:
	'*':
		- apache2
```

#### 创建执行文件

```
vim /srv/salt/apache2/apache2.sls
```

输入下面的内容

```
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
        - user: root
        - group: root
        - options: v
        - if_missing: /var/www/html/page

```


#### 执行

```
salt '*' state.highstate
```
