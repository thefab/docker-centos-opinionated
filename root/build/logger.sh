#!/bin/bash

# We just copy the binary in /usr/local
# /usr/bin/logger will we destroyed at the "remote build dependencies" 
# phase
yum -y install util-linux-ng.x86_64
cp -f /usr/bin/logger /usr/local/bin/logger
