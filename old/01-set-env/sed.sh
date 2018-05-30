#!/bin/bash

# sudo sed -i '$ a\DEV_SERVER=https://dev.shiyanlou.com' /etc/environment
sudo sed -i '$ a\DEV_SERVER=https://dev.shiyanlou.com' /etc/profile
sed -i '$ a\DEV_ACCOUNT=shiyanlou' /home/shiyanlou/.zshrc
