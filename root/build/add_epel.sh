#!/bin/bash

set -e

rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
cat /etc/yum.repos.d/epel.repo |sed 's/enabled=1/enabled=0/g' >/etc/yum.repos.d/epel.repo.new
mv -f /etc/yum.repos.d/epel.repo.new /etc/yum.repos.d/epel.repo
