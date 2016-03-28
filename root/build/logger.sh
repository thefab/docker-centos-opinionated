#!/bin/bash

# We just copy the binary in /usr/local
# /usr/bin/logger will we destroyed at the "remote build dependencies" 
# phase
cp -f /usr/bin/logger /usr/local/bin/logger
