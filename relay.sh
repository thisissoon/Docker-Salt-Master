#!/bin/bash
# relays and shell commands, but swallows any errors and always returns  with
# an exit status of 0
#
# Useful when docker 'RUN' command receives error codes when installing
# applications that can be ignored
#
# TODO:  if the first arg starts with '-', then only filter using those
# codes.  IE: arg1="-100,101".  In this case we will swallow any 100,101
# error codes, but nothing else so any other error codes will still get
# sent back to docker RUN, which in turn will halt installation
#
# Docker command to install salt via bootstrap
#
# For Debian 7
# ENV RUNLEVEL 2
# RUN ln -s /etc/rc2.d /etc/rc.d
#
# ENV DEBIAN_FRONTEND noninteractive
# ADD relay /usr/local/bin/relay
# RUN apt-get install -y wget ca-certificates
# RUN wget -O /root/install_salt.sh http://bootstrap.saltstack.org
# RUN relay sh /root/install_salt.sh -M -S -D -X -U \
#         -p python-libcloud \
#         -p dmidecode \
#         -p procps \
#         -p pciutils \
#         git develop

trap "echo SIGHUP!" SIGHUP

args="$@"
echo -c "${args[@]}"
/bin/bash -c "${args[@]}"

exit 0
