FROM centos:centos6
MAINTAINER Fabien MARTY <fabien.marty@gmail.com>

# Update the image
RUN yum update -y

# Add runtime dependencies
RUN yum -y install json-c.x86_64 libestr.x86_64

# Add build dependencies
RUN mkdir /build && rpm -qa --qf '%{name}\n' >/build/original_packages.list && \
    yum install -y gcc wget tar libestr-devel.x86_64 json-c-devel.x86_64 zlib-devel.x86_64 libuuid-devel.x86_64 libcurl-devel.x86_64 byacc flex autoconf automake libtool gettext

# Add custom files
COPY root /

# Build and install logger
RUN /build/logger.sh

# Add "S6 overlay" (https://github.com/just-containers/s6-overlay)
RUN /build/s6_overlay.sh

# Build and install rsyslog
RUN /build/rsyslog.sh 2

# Build and install cronie
RUN /build/cronie.sh 3

# Remove build dependencies
RUN rpm -qa --qf '%{name}\n' >/build/new_packages.list && \
    for PACKAGE in `cat /build/new_packages.list`; do N=`grep "^${PACKAGE}$" /build/original_packages.list |wc -l`; if test ${N} -eq 0; then rpm -qi ${PACKAGE} >/dev/null 2>&1; if test $? -eq 0; then yum remove -y $PACKAGE; fi; fi; done && \
    yum clean all && \
    rm -Rf /build

ENV DCO_CRONIE_START=1 \
    DCO_RSYSLOG_START=1 \
    DCO_RSYSLOG_REMOTE_HOST=null \
    DCO_RSYSLOG_REMOTE_PORT=514

ENTRYPOINT ["/init"]
