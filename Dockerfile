#
# Salt Stack Salt Master Container
#

FROM ubuntu:14.04
MAINTAINER SOON_ <dorks@thisissoon.com>

# Update System
RUN apt-get update && apt-get upgrade -y -o DPkg::Options::=--force-confold

# Dependencies

RUN apt-get install -y software-properties-common

# Add the Salt Stack Repository

RUN add-apt-repository -y ppa:saltstack/salt

# Install Salt-Master and Salt Syndic

RUN apt-get install -y salt-master salt-syndic

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
