#!/bin/bash

VERSION=2.27.1
ARCHIVE_NAME=v${VERSION}.tar.gz
DIR_NAME=util-linux-${VERSION}
ARCHIVE_URL=https://github.com/karelzak/util-linux/archive/${ARCHIVE_NAME}
BUILD_DIR=/build

wget -O ${BUILD_DIR}/${ARCHIVE_NAME} ${ARCHIVE_URL}
cd ${BUILD_DIR} || exit 1
zcat ${ARCHIVE_NAME} |tar xvf -
cd ${DIR_NAME} || exit 1

./autogen.sh
./configure --prefix=/usr/local
make logger
cp logger /usr/local/bin/
