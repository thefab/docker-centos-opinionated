#!/bin/bash

set -e

yum install --enablerepo=epel -y gcc wget tar byacc flex autoconf automake libtool gettext rpm-build python-virtualenv yum-plugin-downloadonly
