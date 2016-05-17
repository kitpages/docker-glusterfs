#!/bin/bash

# check if GLUSTER_PEER is defined in env vars
if [ "${GLUSTER_PEER}" == "CHANGE_MY_NAME" ]; then
	(<&2 echo "ERROR : you have to name your peer (it is probably different from CHANGE_MY_NAME)")
   	exit 1
fi

# check if GLUSTER_PEER is inside GLUSTER_PEER_LIST
IFS="|" read -ra GLUSTER_PEER_BASH_ARRAY <<< "${GLUSTER_PEER_LIST}"
IN_ARRAY="n"
for i in "${GLUSTER_PEER_BASH_ARRAY[@]}"; do
	if [ "${GLUSTER_PEER}" == "$i" ]; then
		IN_ARRAY="y"
	fi
done
if [ "$IN_ARRAY" == "n" ]; then
	(>&2 echo "ERROR : GLUSTER_PEER not in GLUSTER_PEER_LIST")
	exit 1
fi

# calculate number of replicat from server list
export GLUSTER_REPLICA=${#GLUSTER_PEER_BASH_ARRAY[@]}
export GLUSTER_VOLUME_NAME=gv0
export GLUSTER_BRICK_PATH=/gluster_data/brick1/${GLUSTER_VOLUME_NAME}


echo "PEER = ${GLUSTER_PEER}"
echo "PEER LIST = ${GLUSTER_PEER_LIST}"
echo "NUMBER OF REPLICA = ${GLUSTER_REPLICA}"
echo "BRICK_PATH = ${GLUSTER_BRICK_PATH}"
