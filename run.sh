#!/bin/bash

#
# Salt-Master Run Script
#

set -e

# Log Level
LOG_LEVEL=${LOG_LEVEL:-"error"}

# Run Salt as a Deamon
/usr/bin/salt-master -l $LOG_LEVEL
