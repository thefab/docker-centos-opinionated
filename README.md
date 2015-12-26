# docker-centos-opinionated

## Badges, warnings and links

[![Build Status](https://travis-ci.org/thefab/docker-centos-opinionated.svg?branch=master)](https://travis-ci.org/thefab/docker-centos-opinionated)
[![](https://badge.imagelayers.io/thefab/centos-opinionated:latest.svg)](https://imagelayers.io/?images=thefab/centos-opinionated:centos6 'badge from imagelayers.io')
[This image on the "Docker Hub"](https://hub.docker.com/r/thefab/centos-opinionated/)

**WARNING: alpha stage quality**

## Features

This repository holds an opinionated centos (v6) docker image to be used as a 
base docker image. Some inspiration sources are given at the end of this file.

Features:

- Updated image (at build time)
- Reasonable size (125MB compressed on the hub), reasonable number of layers (10) with a squashed Dockerfile (and another one to debug)
- Don't add too many packages (6) by recompiling and installing just what's needed
- Init system and multiple processes launcher/supervisor ([http://skarnet.org/software/s6/overview.html](s6))
- (optional) syslog daemon ([http://www.rsyslog.com/](rsyslog)) and logger binary, can store locally or forward to another syslog with a simple environnement variable
- (optional) complete cron/anacron daemon ([[https://fedorahosted.org/cronie/](cronie))
- logrotate system

## Non-Features

- we don't want a SSH daemon

## Usage and configuration

Not really usefull (because it's mainly a base image to use in the `FROM` keyword) but you can play with it with (for example):

    docker run -i -t thefab/centos-opinionated:centos6 bash

Available environnement variables:

- `DCO_CRONIE_START` (if "1" (default) then starts the cron daemon)
- `DCO_RSYSLOG_START` (if "1" (default) then starts the syslog daemon)
- `DCO_RSYSLOG_REMOTE_HOST` (if "null" (default) then don't send logs to another syslog daemon, else forward logs to this hostname)
- `DCO_RSYSLOG_REMOTE_PORT` (the remote UDP port of the (optional) remote syslog daemon, default value: 514)

## Help wanted 

- CentOS 7 version

## (some) Inspiration sources

- [http://blog.tutum.co/2014/10/28/the-5-most-important-things-ive-learned-from-using-docker/](the-5-most-important-things-ive-learned-from-using-docker)
- [http://blog.tutum.co/2014/12/02/docker-and-s6-my-new-favorite-process-supervisor/](docker-and-s6-my-new-favorite-process-supervisor)
- [http://phusion.github.io/baseimage-docker/](baseimage-docker)
- [https://github.com/just-containers/s6-overlay](s6-overlay)
- [http://skarnet.org/software/s6/overview.html](s6)
- [http://www.rsyslog.com/](rsyslog)
- [https://fedorahosted.org/cronie/](cronie)
