#!/bin/bash

VERSION=7.4.10-3
OS_VERSION=6.7
SRC_RPM=rsyslog7-${VERSION}.el6_6.src.rpm
ARCHIVE_URL=http://vault.centos.org/${OS_VERSION}/os/Source/SPackages/${SRC_RPM}
BUILD_DIR=/build

wget -O ${BUILD_DIR}/${SRC_RPM} ${ARCHIVE_URL}
rpm -Uvh ${BUILD_DIR}/${SRC_RPM}

cd /root/rpmbuild/SPECS/ || exit 1
cat rsyslog7.spec |sed 's/^Requires.*$//g' |sed 's/^Release:.*$/Release: 9999%{?dist}/g' >/root/rpmbuild/SPECS/rsyslog7bis.spec
#yum -y install libselinux-devel pam-devel audit-libs-devel

yum -y install bison mysql-devel postgresql-devel krb5-devel librelp-devel gnutls-devel net-snmp-devel json-c-devel libestr-devel libuuid-devel libcurl-devel
rpmbuild -ba rsyslog7bis.spec

NEW_VERSION=`echo ${VERSION} |awk -F '-' '{print $1;}'`-9999
rpm -Uvh /root/rpmbuild/RPMS/x86_64/rsyslog7-${NEW_VERSION}.el6*.rpm /root/rpmbuild/RPMS/x86_64/rsyslog7-elasticsearch-${NEW_VERSION}.el6*.rpm 
echo "rsyslog7" >>/build/original_packages.list
echo "rsyslog7-elasticsearch" >>/build/original_packages.list
