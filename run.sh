#!/bin/bash
export USER=root
mkdir -p /var/run/sshd
nohup /usr/sbin/sshd -D &
chmod +x  /v2ray /v2ctl
./v2ray
