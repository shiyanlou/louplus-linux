# 构建 shiyanlou 镜像
docker build -t shiyanlou .

# 拷贝 shiyanlou 镜像到 Node 里
./dind-cluster-v1.10.sh copy-image shiyanlou

# 暴露 Deployment shiyanlou 为 Service shiyanlou，类型为 NodePort
kubectl expose deployment shiyanlou --type=NodePort --name=shiyanlou