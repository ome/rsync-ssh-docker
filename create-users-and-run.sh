#!/bin/sh
set -eu

GROUPID="${GROUPID:-1000}"
addgroup -g $GROUPID rsync
for USER in $GITHUB_USERS; do
    adduser -G rsync -s /bin/sh -D $USER
    echo $USER:$(head -c30 /dev/urandom | base64) | chpasswd
    mkdir /home/$USER/.ssh
    wget -q -O /home/$USER/.ssh/authorized_keys https://github.com/$USER.keys
    chown -R $USER:rsync /home/$USER/.ssh
    chmod -R go-wx /home/$USER/.ssh
done

exec /usr/sbin/sshd -eD
