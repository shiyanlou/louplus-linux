#!/bin/bash

sudo groupadd test
sudo groupadd dev

sudo useradd -m -d /home/jack -s /bin/zsh -g shiyanlou -G dev jack
sudo useradd -m -d /home/bob -s /bin/bash -g shiyanlou -G test bob
