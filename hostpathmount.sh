#!/bin/bash
## This is to be run on each node on which you want to mound a hostpath

#MOUNTPATH=${1:-"/local"}

#echo $MOUNTPATH 

setsebool virt_sandbox_use_mknod on
setsebool virt_sandbox_use_netlink on
setsebool virt_sandbox_use_sys_admin on
setsebool unprivuser_use_svirt on

mkdir -p /local
chown -R :1000 /local/
semanage fcontext -a -tsvirt_sandbox_file_t "/local(/.*)?"
restorecon -R -v /local

