#!/bin/bash

# check if GLUSTER_PEER is defined in env vars
if [ "${GLUSTER_PEER}" == "CHANGE_MY_NAME" ]; then
	(<&2 echo "ERROR : you have to name your peer (it is probably different from CHANGE_MY_NAME)")
   	exit 1
fi

# check if GLUSTER_PEER is inside GLUSTER_PEER_LIST
IFS="|" read -ra TAB <<< "${GLUSTER_PEER_LIST}"
IN_ARRAY="n"
for i in "${TAB[@]}"; do
	if [ "${GLUSTER_PEER}" == "$i" ]; then
		IN_ARRAY="y"
	fi
done
if [ "$IN_ARRAY" == "n" ]; then
	(>&2 echo "ERROR : GLUSTER_PEER not in GLUSTER_PEER_LIST")
	exit 1
fi

# calculate number of replicat from server list
export GLUSTER_REPLICA=${#TAB[@]}

echo "PEER = ${GLUSTER_PEER}"
echo "PEER LIST = ${GLUSTER_PEER_LIST}"
echo "NUMBER OF REPLICA = ${GLUSTER_REPLICA}"

PARAMETER_LIST=`for i in "${TAB[@]}"; do echo "$i:/data/brick1/gv0";done `
echo "PARAMETER_LIST = ${PARAMETER_LIST}"

gluster volume create gv0 replica ${GLUSTER_REPLICA} ${PARAMETER_LIST}

