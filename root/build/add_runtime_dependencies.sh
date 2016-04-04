#!/bin/bash

mkdir -p /build
yum --enablerepo=epel install -y json-c.x86_64 libestr.x86_64 logrotate
rpm -qa --qf '%{name}\n' >/build/original_packages.list
