#!/bin/bash

source $(dirname $0)/common.sh

gluster volume info ${GLUSTER_VOLUME_NAME}
if [ $? -ne 0 ]; then
	setfattr -x trusted.glusterfs.volume-id ${GLUSTER_BRICK_PATH}
	setfattr -x trusted.gfid ${GLUSTER_BRICK_PATH}
	rm -rf ${GLUSTER_BRICK_PATH}/.glusterfs
fi

# check if GLUSTER_PEER is inside GLUSTER_PEER_LIST
IN_ARRAY="n"
for i in "${GLUSTER_PEER_BASH_ARRAY[@]}"; do
	if [ "${GLUSTER_PEER}" != "$i" ]; then
		gluster peer probe "${i}"
		echo "${GLUSTER_PEER} probes peer ${i}"
	fi
done
