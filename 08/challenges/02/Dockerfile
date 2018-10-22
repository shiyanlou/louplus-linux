# 使用 python:3.5 作为基础镜像
FROM registry.cn-hangzhou.aliyuncs.com/louplus-linux/python:3.5

# 从构建上下文里拷贝 app.py 到当前工作目录下
# 当前工作目录会继承于基础镜像，可以使用 WORKDIR 指令来修改
COPY app.py .

# 安装 pip 依赖包
RUN pip install flask

# 设置 Flask 应用路径环境变量
ENV FLASK_APP=app.py

# 启动本镜像的容器时将运行的命令
CMD [ "flask", "run", "-h", "0.0.0.0", "-p", "5000" ]
