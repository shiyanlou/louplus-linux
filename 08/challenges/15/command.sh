#!/bin/bash

# 将 Deployment shiyanlou 暴露为 Service shiyanlou-service
kubectl expose deployment shiyanlou --type=NodePort --name=shiyanlou-service
