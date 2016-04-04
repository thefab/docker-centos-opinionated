#!/bin/bash

rm -Rf /build/downloadonly
mkdir -p /build/downloadonly
yum install crontabs -y --downloadonly --downloaddir=/build/downloadonly

VERSION=1.4.4-15
OS_VERSION=6.7
SRC_RPM=cronie-${VERSION}.el6.src.rpm
ARCHIVE_URL=http://vault.centos.org/${OS_VERSION}/os/Source/SPackages/${SRC_RPM}
BUILD_DIR=/build

wget -O ${BUILD_DIR}/${SRC_RPM} ${ARCHIVE_URL}
rpm -Uvh ${BUILD_DIR}/${SRC_RPM}

cd /root/rpmbuild/SPECS/ || exit 1
cat cronie.spec |sed 's/^Requires.*$//g' |sed 's/^Release:.*$/Release: 9999%{?dist}/g' >/root/rpmbuild/SPECS/cronie2.spec
yum -y install libselinux-devel pam-devel audit-libs-devel
rpmbuild -ba cronie2.spec

NEW_VERSION=`echo ${VERSION} |awk -F '-' '{print $1;}'`-9999
rpm -Uvh /build/downloadonly/crontabs*.rpm /root/rpmbuild/RPMS/x86_64/cronie-anacron-${NEW_VERSION}.el6*.rpm /root/rpmbuild/RPMS/x86_64/cronie-${NEW_VERSION}.el6*.rpm
echo "cronie" >>/build/original_packages.list
echo "cronie-anacron" >>/build/original_packages.list
echo "crontabs" >>/build/original_packages.list
