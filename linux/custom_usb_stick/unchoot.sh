exit &&
sudo umount $chrootdev/sys &&
sudo umount $chrootdev/proc &&
sudo umount $chrootdev/dev/pts &&
sudo umount $chrootdev/dev &&
sudo umount $chrootdev
