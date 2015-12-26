#!/bin/bash

cd /build || exit 1
rpmbuild -ba centos_opinionated.spec
rpm -Uvh /root/rpmbuild/RPMS/x86_64/centos_opinionated-1.0.0-1.x86_64.rpm
