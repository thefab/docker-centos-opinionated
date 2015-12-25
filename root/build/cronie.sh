#!/bin/bash

VERSION=1.5.0
ARCHIVE_NAME=cronie-${VERSION}.tar.gz
DIR_NAME=cronie-${VERSION}
ARCHIVE_URL=https://fedorahosted.org/releases/c/r/cronie/${ARCHIVE_NAME}
BUILD_DIR=/build

wget -O ${BUILD_DIR}/${ARCHIVE_NAME} ${ARCHIVE_URL}
cd ${BUILD_DIR} || exit 1
zcat ${ARCHIVE_NAME} |tar xvf -
cd ${DIR_NAME} || exit 1

./configure --enable-anacron --enable-syscrontab --enable-syscrontab --prefix=
make
make install

mkdir -p /var/spool/cron
chmod 777 /var/spool/cron
touch /etc/cron.deny
mkdir -p /var/spool/anacron
chmod 777 /var/spool/anacron
for FREQ in hourly daily weekly monthly; do 
    mkdir -p /etc/cron.${FREQ}
    if test ${FREQ} != "hourly"; then
        touch /var/spool/anacron/cron.${FREQ}
    fi
done
mkdir -p /etc/cron.d
cp -f ${BUILD_DIR}/${DIR_NAME}/contrib/anacrontab /etc/anacrontab
cp -f ${BUILD_DIR}/${DIR_NAME}/contrib/0hourly /etc/cron.d/0hourly
cp -f ${BUILD_DIR}/${DIR_NAME}/contrib/0anacron /etc/cron.hourly/0anacron
