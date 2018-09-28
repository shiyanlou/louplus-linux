#!/bin/bash

cd ~
find /etc -type f -name \*.conf 2> error.txt | sort > conflist.txt
