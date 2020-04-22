#!/bin/bash
export USER=root
mkdir -p /var/run/sshd
/usr/sbin/sshd -D 

