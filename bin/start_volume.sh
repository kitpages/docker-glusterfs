#!/bin/bash

source $(dirname $0)/common.sh

PARAMETER_LIST=`for i in "${GLUSTER_PEER_BASH_ARRAY[@]}"; do echo -n "${i}:${GLUSTER_BRICK_PATH} ";done `
echo "PARAMETER_LIST = ${PARAMETER_LIST}"

gluster volume info gv0
if [ $? -ne 0 ]; then
	gluster volume create gv0 replica ${GLUSTER_REPLICA} ${PARAMETER_LIST}
fi
gluster volume start gv0
