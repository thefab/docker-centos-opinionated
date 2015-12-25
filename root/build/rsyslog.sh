#!/bin/bash

VERSION=8.15.0
ARCHIVE_NAME=rsyslog-${VERSION}.tar.gz
DIR_NAME=rsyslog-${VERSION}
ARCHIVE_URL=http://www.rsyslog.com/files/download/rsyslog/${ARCHIVE_NAME}
BUILD_DIR=/build

wget -O ${BUILD_DIR}/${ARCHIVE_NAME} ${ARCHIVE_URL}
cd ${BUILD_DIR} || exit 1
zcat ${ARCHIVE_NAME} |tar xvf -
cd ${DIR_NAME} || exit 1
export PKG_CONFIG_PATH=/lib64/pkgconfig:/usr/lib64/pkgconfig
./configure --prefix=/ --disable-libgcrypt --disable-liblogging-stdlog --enable-omprog --enable-elasticsearch --enable-omhttpfs
make
make install
mkdir -p /var/lib/rsyslog
