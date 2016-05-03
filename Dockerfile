FROM ubuntu:15.10

MAINTAINER Philippe Le Van (twitter: @plv)

RUN apt-get update && \
    apt-get install -y python-software-properties software-properties-common && \
	add-apt-repository -y ppa:gluster/glusterfs-3.7 && \
    apt-get update && \
    apt-get install -y glusterfs-server supervisor && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /var/log/supervisor

VOLUME ["/gluster_data"]
VOLUME ["/var/lib/glusterd"]
VOLUME ["/var/log/glusterfs"]

RUN mkdir -p /usr/local/bin
ADD ./bin /usr/local/bin
RUN chmod +x /usr/local/bin/*.sh
ADD ./etc/supervisord.conf /etc/supervisor/supervisord.conf

CMD ["/usr/local/bin/run_daemon.sh"]
