#!/bin/bash

docker run -d --env-file /home/shiyanlou/env_file -p 3306:3306 mysql:5.5
