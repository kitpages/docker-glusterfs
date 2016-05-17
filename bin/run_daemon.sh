#!/bin/bash

source $(dirname $0)/common.sh

mkdir -p ${GLUSTER_BRICK_PATH}

# run glusterd with supervisord
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
