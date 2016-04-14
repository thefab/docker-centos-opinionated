#!/bin/bash

set -e

mkdir -p /build
yum --enablerepo=epel install -y logrotate libestr json-c
rpm -qa --qf '%{name}\n' >/build/original_packages.list
