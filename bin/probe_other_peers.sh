#!/bin/bash

# check if GLUSTER_PEER is inside GLUSTER_PEER_LIST
IFS="|" read -ra TAB <<< "${GLUSTER_PEER_LIST}"
IN_ARRAY="n"
for i in "${TAB[@]}"; do
	if [ "${GLUSTER_PEER}" != "$i" ]; then
		gluster peer probe "${i}"
		echo "${GLUSTER_PEER} probes peer ${i}"
	fi
done
