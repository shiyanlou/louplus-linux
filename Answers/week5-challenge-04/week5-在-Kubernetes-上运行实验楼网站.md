# 挑战：在 Kubernetes 上运行实验楼网站

首先启动集群环境：

```bash
./dind-cluster-v1.15.sh up
```

#### 构建镜像

创建一个子目录来构建镜像，以避免发送大量无关文件给 Docker 服务：

```bash
mkdir -p challenge && cd challenge
```

`index.html` 文件内容如下所示：

```html
<html>
    <head>
        <title>Shiyanlou</title>
    </head>
    <body>
        <h1>Welcome to Shiyanlou!</h1>
    </body>
</html>
```

`Dockerfile` 文件内容如下所示：

```dockerfile
# 基础镜像
FROM registry.cn-hangzhou.aliyuncs.com/louplus-linux/nginx:1.9.1

# 拷贝网站代码，就一个首页
COPY index.html /usr/share/nginx/html/
```

构建镜像：

```bash
docker build -t shiyanlou .
```

#### 拷贝镜像到集群的节点里

```bash
cd /home/shiyanlou
./dind-cluster-v1.15.sh copy-image shiyanlou
```

#### 创建 deployment

`deployment.yaml` 文件内容如下所示：

```yaml
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  labels:
    app: shiyanlou
  name: shiyanlou
spec:
  replicas: 2
  selector:
    matchLabels:
      app: shiyanlou
  template:
    metadata:
      labels:
        app: shiyanlou
    spec:
      containers:
      - name: shiyanlou
        image: shiyanlou
        imagePullPolicy: Never
        ports:
        - containerPort: 80
          name: http
```

创建 Deployment：

```bash
kubectl apply -f deployment.yaml
```

#### 暴露服务

将 Deployment shiyanlou 暴露为 Service shiyanlou-service：

```bash
kubectl expose deployment shiyanlou --type=NodePort --name=shiyanlou-service
```

查看 NodeIP：

```bash
$ kubectl get nodes -o wide
NAME          STATUS   ROLES    AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE                       KERNEL-VERSION      CONTAINER-RUNTIME
kube-master   Ready    master   51d   v1.15.0   10.192.0.2    <none>        Debian GNU/Linux 9 (stretch)   4.4.0-185-generic   docker://18.9.0
kube-node-1   Ready    <none>   51d   v1.15.0   10.192.0.3    <none>        Debian GNU/Linux 9 (stretch)   4.4.0-185-generic   docker://18.9.0
kube-node-2   Ready    <none>   51d   v1.15.0   10.192.0.4    <none>        Debian GNU/Linux 9 (stretch)   4.4.0-185-generic   docker://18.9.0
```

可以看到 kube-master 的端口为 10.192.0.2。

查看 NodePort：

```bash
$ kubectl get services
NAME                TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
kubernetes          ClusterIP   10.96.0.1      <none>        443/TCP        51d
shiyanlou-service   NodePort    10.108.90.20   <none>        80:31366/TCP   13s
```

可以看到 NodePort 为 31366。

最后打开火狐浏览器，访问 `10.192.0.2:31366`，可以看到 `Welcome to Shiyanlou!` 的字样。

