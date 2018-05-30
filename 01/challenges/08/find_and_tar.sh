#!/bin/bash

cd ~
mkdir backup
# find /etc -type f -size +12k -print0 2> /dev/null | xargs -0 -i  cp --parents {} backup 2> /dev/null
find /etc -type f -size +12k -exec cp --parents {} ~/backup \; 2> /dev/null
tar czf /tmp/backup.tar.gz backup
