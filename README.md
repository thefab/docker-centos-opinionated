# docker-centos-opinionated

[![Travis](https://img.shields.io/travis/thefab/docker-centos-opinionated.svg)](https://travis-ci.org/thefab/docker-centos-opinionated)
[![Docker Pulls](https://img.shields.io/docker/pulls/thefab/centos-opinionated.svg)](https://hub.docker.com/r/thefab/centos-opinionated/)
[![DockerHub](https://img.shields.io/badge/docker%20hub-link-green.svg)](https://hub.docker.com/r/thefab/centos-opinionated/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/thefab/docker-centos-opinionated/blob/master/LICENSE)
[![Maturity](https://img.shields.io/badge/maturity-beta-yellow.svg)](https://github.com/thefab/docker-centos-opinionated)
[![Maintenance](https://img.shields.io/maintenance/yes/2017.svg)](https://github.com/thefab)

## Features

This repository holds an opinionated centos (version 6) docker image to be used as a 
base docker image. Some inspiration sources are given at the end of this file.

Features:

- Updated image (at build time)
- Reasonable size (106MB compressed on the hub), reasonable number of layers (9) with a squashed Dockerfile (and another one to debug)
- Don't add too many packages by recompiling and installing just what's needed
- Don't break the upstream system :
    - rebuild cronie et rsyslog7 from "upstream source RPM" (with some tuning to avoid too much dependencies in docker context)
    - tricks to avoid distribution interferences (hidden virtualenv in non-standard prefix) 
- Init system and multiple processes launcher/supervisor ([S6](http://skarnet.org/software/s6/overview.html))
- (optional) syslog daemon ([rsyslog](http://www.rsyslog.com)) and logger binary, can store locally or forward to another syslog with a simple environnement variable
- (optional) complete cron/anacron daemon ([cronie](https://fedorahosted.org/cronie/))
- logrotate system
- Add [epel](https://fedoraproject.org/wiki/EPEL) yum repository but disabled by default (just add `--enablerepo=epel` to your yum commands to use it)
- Install [envtpl](https://github.com/andreasjansson/envtpl) generic tool to be able to automatically adjust configuration files from environnement

## Non-Features

- we don't want a SSH daemon

## Usage and configuration

Not really usefull (because it's mainly a base image to use in the `FROM` keyword) but you can play with it with (for example):

    docker run -i -t thefab/centos-opinionated:latest bash

Available environnement variables:

- `DCO_CRONIE_START` (if "1" (default) then starts the cron daemon)
- `DCO_RSYSLOG_START` (if "1" (default) then starts the syslog daemon)
- `DCO_RSYSLOG_REMOTE_HOST` (if "null" (default) then don't send logs to another syslog daemon, else forward logs to this hostname)
- `DCO_RSYSLOG_REMOTE_PORT` (the remote UDP port of the (optional) remote syslog daemon, default value: 514)
- `DCO_RSYSLOG_LOCAL_FILES` (if "1" (default) then log to local files in /var/log)

## FAQ

### How to override this image to add your service on top of it ?

When you start this image with the default "entrypoint" (`/init`), it launch the S6 process supervisor (see links at the end) 
provided by the [s6-overlay](https://github.com/just-containers/s6-overlay).

First, it executes `/etc/cont-init.d/*` initialization (short) tasks. Then, it launchs `/etc/services/*/run` script. This script
must execute your daemon in a long-lived way and will have to deal with signals. If this "run script" exits, it will be automatically 
restarted. An easy way to write a such script is to use the "exec" bash builtin with the "foreground mode" startup command of your service.

For example:

```bash
#!/bin/sh

exec /sbin/rsyslogd -n
```

Because of "exec", the script will be replaced by the launched command. So you won't have to deal with signals by yourself.

So a complete example to override this image with a new service on top of it can be:

```
$ find my_image

my_image/
my_image/Dockerfile
my_image/root
my_image/root/etc
my_image/root/etc/cont-init.d
my_image/root/etc/cont-init.d/my_initialization_script
my_image/root/etc/services.d
my_image/root/etc/services.d/myapp
my_image/root/etc/services.d/myapp/run
```

With `my_image/Dockerfile` like:

```
FROM thefab/centos-opinionated

COPY root /
```

And that's all ! Your custom service will be executed as well as rsyslog, cron services provides by the base image.

## Can i use CMD with the init entrypoint ?

Yes, quotted from the [s6-overlay](https://github.com/just-containers/s6-overlay) README:

> Using CMD is a really convenient way to take advantage of the s6-overlay. 
> Your CMD can be given at build-time in the Dockerfile, or at runtime on the command line, either way is fine - it will be run under the s6 supervisor, and when it fails or exits, the container will exit. You can even run interactive programs under the s6 supervisor!

Please consult [s6-overlay](https://github.com/just-containers/s6-overlay) REAME for examples and more details.

### Why I can't access to my environnement variables in my services script ?

Because of S6 overlay. If you want to use environnement variables in your scripts, you have to change your shebang to use the "with-contenv" 
S6 helper. 

Example 1 (won't work):  

```bash
#!/bin/bash

# don't work example

do_something_with ${MY_CONTAINER_ENV}
```

Example 2 (will work):

```bash
#!/usr/bin/with-contenv bash

do_something_with ${MY_CONTAINER_ENV}
```

### What about CentOS 7 version ?

This repository is only about CentOS 6 version.

A slightly different version of this repository for CentOS 7 is available at:

https://github.com/metwork-framework/docker-centos7-opinionated

## (some) Inspiration sources

- [the-5-most-important-things-ive-learned-from-using-docker](http://blog.tutum.co/2014/10/28/the-5-most-important-things-ive-learned-from-using-docker/)
- [docker-and-s6-my-new-favorite-process-supervisor](http://blog.tutum.co/2014/12/02/docker-and-s6-my-new-favorite-process-supervisor/)
- [baseimage-docker](http://phusion.github.io/baseimage-docker/)
- [s6-overlay](https://github.com/just-containers/s6-overlay)
- [s6](http://skarnet.org/software/s6/overview.html)
- [rsyslog](http://www.rsyslog.com/)
- [cronie](https://fedorahosted.org/cronie/)
