#!/bin/bash

mkdir -p /build
rpm -qa --qf '%{name}\n' >/build/original_packages.list

yum install -y gcc wget tar libestr-devel.x86_64 json-c-devel.x86_64 zlib-devel.x86_64 libuuid-devel.x86_64 libcurl-devel.x86_64 byacc flex autoconf automake libtool gettext
