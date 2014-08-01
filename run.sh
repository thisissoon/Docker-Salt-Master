#!/bin/bash

#
# Salt-Master Run Script
#

set -e

# Log Level
LOG_LEVEL=${LOG_LEVEL:-"error"}

# Run Salt as a Deamon
exec sudo /usr/bin/salt-master --log-level=$LOG_LEVEL
