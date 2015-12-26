#!/bin/bash

rpm -qa --qf '%{name}\n' >/build/new_packages.list

for PACKAGE in `cat /build/new_packages.list`; do
    N=`grep "^${PACKAGE}$" /build/original_packages.list |wc -l`
    if test ${N} -eq 0; then 
        rpm -qi ${PACKAGE} >/dev/null 2>&1
        if test $? -eq 0; then
            yum remove -y $PACKAGE
        fi
    fi
done
yum clean all
rm -Rf /build /root/rpmbuild
