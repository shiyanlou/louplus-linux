# 构建 shiyanlou 镜像
docker build -t shiyanlou .

# 拷贝 shiyanlou 镜像到 Node 里
./dind-cluster-v1.10.sh copy-image shiyanlou

# 创建 Deployment
kubectl apply -f deployment.yaml
