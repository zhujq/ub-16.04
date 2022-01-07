#!/bin/bash
export USER=root
mkdir -p /var/run/sshd
nohup /usr/sbin/sshd -D &
chmod +x /s5 /v2ray /v2ctl
nohup /s5 &
./v2ray
