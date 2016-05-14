docker-glusterfs
================

This docker is used to create a glusterfs cluster. This creates a 
node (brick) for gluster fs.

Status : unstable, early alpha.

Quick start
-----------

image you have a plateform with 3 servers named data1, data2 and data3.

In your /etc/hosts of each server, you have the definition of the servers

```
10.0.0.101 data1
10.0.0.102 data2
10.0.0.103 data3
```

1) run the gluster daemon on each node

data1 has to be replaced by data2 or data3 for the GLUSTER_BRICK env var.

```bash
for server in data1 data2 data3; do
    ssh root@${server} "
        docker run --rm -d --name=glusterfs --privileged=true \
            --net=host \
            --env GLUSTER_PEER=${server} \
            --env GLUSTER_VOLUME=my_volume \
            --env GLUSTER_PEER_LIST='data1|data2|data3' \
            --volume /etc/hosts:/etc/hosts:ro \
            --volume /var/gluster/data:/gluster_data \
            kitpages/docker-glusterfs /usr/local/bin/run_daemon.sh \
    "
done
```

2) probe all daemons.

on each nodes

```bash
for server in data1 data2 data3; do
    ssh root@${server} "
        docker exec -i glusterfs /usr/local/bin/probe_other_peers.sh
    "
done
```

3) start the volume

On anyone of the nodes

```bash
docker exec -i glusterfs /usr/local/bin/start_volume.sh
```

4) connect the client to the cluster



References
----------

This dockerfile is a bit inspired from this blog post from rancher :
http://rancher.com/creating-a-glusterfs-cluster-for-docker-on-aws/

