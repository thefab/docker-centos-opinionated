FROM centos:centos6
MAINTAINER Fabien MARTY <fabien.marty@gmail.com>

# Update the image and install additional packages
RUN yum update -y && yum -y install tar

# Add s6 overlay v1.17.1.1 (https://github.com/just-containers/s6-overlay)
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.17.1.1/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

ENTRYPOINT ["/init"]
