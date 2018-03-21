#!/bin/bash
## This is to be run on each node on which you want to mound a hostpath
## Argument = -d local directory

usage()
{
cat << EOF
usage: $0 options
This script creates the local directory to be used a host path if it does not exit. 
It is run on the node (or each node) the host path is to be mounted.

OPTIONS:
    -h		show this message
    -d		Directory path (if none /local will be used)
    -v		verbose
EOF
}

MOUNTPATH="/local"
VERBOSE=

while getopts “hd:v” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         d)
             MOUNTPATH=$OPTARG
             ;;
         v)
             VERBOSE=1
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

if [[ -z "$MOUNTPATH" ]] || [[ "/local" == "$MOUNTPATH" ]]
then
     echo "/local will be used as the mount path. If you want to change this enter <directory path> within the next 10 seconds or [Ctl + C] to cancel" 
read -t 10 MOUNTPATH
fi

echo "The mount path is : $MOUNTPATH"

setsebool virt_sandbox_use_mknod on
setsebool virt_sandbox_use_netlink on
setsebool virt_sandbox_use_sys_admin on
setsebool unprivuser_use_svirt on

mkdir -p $MOUNTPATH 
chown -R :1000 $MOUNTPATH/
semanage fcontext -a -t svirt_sandbox_file_t "$MOUNTPATH(/.*)?"
restorecon -R -v $MOUNTPATH
