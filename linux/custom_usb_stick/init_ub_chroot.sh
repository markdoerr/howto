#!/bin/sh

export mint171=/home/mark/temp/custom_mint/squashfs

mount --rbind /dev $mint171/dev/
mount --rbind /sys $mint171/sys/
mount --rbind /proc $mint171/proc/

cp /etc/resolv.conf $mint171/etc/

cp policy-rc.d $mint171/usr/sbin/
chmod a+x $mint171/usr/sbin/policy-rc.d

mkdir -p $mint171/tmp/.X11-unix
mount --rbind /tmp/.X11-unix $mint171/tmp/.X11-unix/

xhost + local:
xhost + localhost
