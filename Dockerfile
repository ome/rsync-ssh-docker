FROM alpine:3.7
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

RUN apk add -U \
    openssh-server \
    rsync && \
    rm -f /var/cache/apk/*
ADD sshd_config /etc/ssh/
# WARNING: The ssh server key is fixed at build time, rebuild to change the key
RUN /usr/bin/ssh-keygen -q -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N ''
ADD create-users-and-run.sh /usr/local/bin/

EXPOSE 22
ENTRYPOINT ["create-users-and-run.sh"]
#STOPSIGNAL INT
