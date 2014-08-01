#
# Salt Stack Salt Master Container
#

FROM ubuntu:14.04
MAINTAINER SOON_ <dorks@thisissoon.com>

# Update System
RUN apt-get update && apt-get upgrade -y -o DPkg::Options::=--force-confold

# Salt BootStrap

ADD https://bootstrap.saltstack.com install_salt.sh
RUN sudo sh install_salt.sh git v2014.7

# Volumes

VOLUME ['/etc/salt/master.d', '/srv/salt']

# Add confiugruation file

ADD master /etc/salt/master.d/master

# Add Run File

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Ports

EXPOSE 4505 4506

# Run Command

CMD "/usr/local/bin/run.sh"
