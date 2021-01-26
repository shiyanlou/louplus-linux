# 挑战：通过 Docker 来运行实验楼网站

app.py 文件内容如下所示：

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return 'Welcome to Shiyanlou!'
```

shiyanlou.conf 文件内容如下所示：

```conf
server {
    listen      80;
    server_name shiyanlou.com;

    # 转发所有请求到后端服务 shiyanlou:5000
    location / {
        proxy_pass http://shiyanlou:5000;
    }
}
```

Dockerfile 文件内容如下所示：

```dockerfile
# 使用 python:3.5 作为基础镜像
FROM registry.cn-hangzhou.aliyuncs.com/louplus-linux/python:3.5

# 从构建上下文里拷贝 app.py 到当前工作目录下
# 当前工作目录会继承于基础镜像，可以使用 WORKDIR 指令来修改
COPY app.py .

# 安装 pip 依赖包
RUN pip3 install flask

# 设置 Flask 应用路径环境变量
ENV FLASK_APP=app.py

# 启动本镜像的容器时将运行的命令
CMD [ "flask", "run", "-h", "0.0.0.0", "-p", "5000" ]
```

完整命令如下：

```bash
# 创建一个子目录来构建镜像，以避免发送大量无关文件给 Docker 服务
mkdir -p challenge && cd challenge

# 创建相关文件，包括 Dockerfile、app.py、shiyanlou.conf

# 构建网站镜像 shiyanlou
docker build -t shiyanlou .

# 创建一个 Docker 网络 shiyanlou
docker network create shiyanlou

# 运行一个容器来提供网站服务，该容器加入到 shiyanlou 网络里
docker run -d --name shiyanlou --network shiyanlou shiyanlou:latest

# 运行一个容器来提供 Nginx 服务，该容器也加入到 shiyanlou 网络里，以便可以访问到网站服务
docker run -d --name nginx --network shiyanlou -v /home/shiyanlou/challenge/shiyanlou.conf:/etc/nginx/conf.d/shiyanlou.conf -p 8080:80 registry.cn-hangzhou.aliyuncs.com/louplus-linux/nginx:1.9.1

sudo vim /etc/hosts
# 添加 Hosts “127.0.0.1   shiyanlou.com”

curl http://shiyanlou.com:8080/
```
