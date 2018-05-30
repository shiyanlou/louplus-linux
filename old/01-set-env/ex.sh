#!/bin/bash

# sudo ex -sc 'a|DEV_SERVER=https://dev.shiyanlou.com' -cx /etc/environment
sudo ex -sc 'a|DEV_SERVER=https://dev.shiyanlou.com' -cx /etc/profile
ex -sc 'DEV_ACCOUNT=shiyanlou' -cx ~/.zshrc
