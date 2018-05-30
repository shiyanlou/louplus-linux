#!/bin/bash

# echo DEV_SERVER="https://dev.shiyanlou.com" | sudo tee -a /etc/environment
echo DEV_SERVER="https://dev.shiyanlou.com" | sudo tee -a /etc/profile
echo DEV_ACCOUNT="shiyanlou" | sudo tee -a /home/shiyanlou/.zshrc
