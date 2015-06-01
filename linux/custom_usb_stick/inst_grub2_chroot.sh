#!/bin/sh

# sudo mkdir /mnt/grub2targetdev
# sudo mount /dev/sdx /mnt/grub2targetdev
 
export grub2target=/mnt/grub2targetdev
export chrootdev=$grub2target 

mount --rbind /dev $grub2target/dev/ &&
mount --rbind /dev/pts $grub2target/dev/pts &&
mount --rbind /sys $grub2target/sys/ &&
mount --rbind /proc $grub2target/proc/ 

#cp /etc/resolv.conf $grub2target/etc/
#cp policy-rc.d $grub2target/usr/sbin/
#chmod a+x $grub2target/usr/sbin/policy-rc.d

#mkdir -p $grub2target/tmp/.X11-unix
#mount --rbind /tmp/.X11-unix $grub2target/tmp/.X11-unix/

#xhost + local:
#xhost + localhost

## chroot

# sudo chroot grub2target

# check target device

# sudo fdisk -l

## install grub
# grub-install /dev/sdX
# grub-install --recheck /dev/sdX
# update-grub
 
