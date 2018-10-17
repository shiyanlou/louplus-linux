# 创建一个子目录来构建镜像，以避免发送大量无关文件给 Docker 服务
mkdir -p challenge && cd challenge

# 构建镜像
docker build -t shiyanlou .

# 拷贝镜像到集群的节点里
./dind-cluster-v1.10.sh copy-image shiyanlou

# 创建 Deployment
kubectl apply -f deployment.yaml
