

# howto describing the procedure to generate a custom ubuntu system
# last modified: 150201

# preperations

sudo mkdir /mnt/ubuntu_flash/

sudo mount -o loop /home/mark/temp/custom_mint/filesystem.squashfs /mnt/ubuntu_flash/

sudo mkdir /home/mark/temp/custom_mint/squashfs
export mint171=/home/mark/temp/custom_mint/squashfs

sudo cp -a /mnt/ubuntu_flash/* $mint171/

sudo mount --rbind /dev $mint171/dev/
sudo mount --rbind /sys $mint171/sys/
sudo mount --rbind /proc $mint171/proc/

sudo cp /etc/resolv.conf $mint171/etc/

# place policy-rc.d in parent directory
sudo cp policy-rc.d $mint171/usr/sbin/
sudo chmod a+x $mint171/usr/sbin/policy-rc.d

# X11 setup

sudo mkdir -p $mint171/tmp/.X11-unix
sudo mount --rbind /tmp/.X11-unix $mint171/tmp/.X11-unix/

sudo xhost + local:
sudo xhost + localhost

# cp all required files to new file system
sudo cp ../truecrypt-7.1a-setup-x86 squashfs/tmp/

sudo chroot $mint171

export DISPLAY=:0
dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl

... make changes ...

apt-get update

# s. linux_mint.txt

when ready:

apt-get clean
apt-get autoclean
apt-get autoremove


rm /sbin/initctl
rm -f $mint171/etc/resolv.conf

exit

sudo umount -l  $mint171/tmp/.X11-unix/
sudo umount  -l  $mint171/sys/
sudo umount -l  $mint171/proc/
sudo umount  -l $mint171/dev/

sudo mv $mint171/usr/sbin/policy-rc.d $mint171/usr/sbin/policy-rc.d_disa

sudo mksquashfs $mint171 filesystem.squashfs -wildcards -e boot/vmlinuz-* boot/initrd.img-*

sudo cp filesystem.squashfs /media/mark/Transcend/casper


Grafische Programme in einer chroot-Umgebung aufrufen
23. Oktober 2005
Ihr Vorhaben

Sie haben unter dem Unterverzeichnis /test ein Linuxsystem installiert oder die Wurzelpartition eines anderen Linuxsystems gemountet. Mit dem Befehl chroot /test können Sie zwar wie gewohnt "hineinwechseln" und Programme aufrufen. Das Starten von grafischen Programmen scheitert aber, selbst wenn Sie DISPLAY auf :0 setzen.
Das Problem

Lokale Programme kommunizieren mit dem X-Server Ihres Rechners über ein Unix-Socket im Verzeichnis /tmp/.X11-unix. In Ihrer chroot-Umgebung gibt keinen Zugriff auf dieses Socket.
Die Lösung

Mit einem mount-Befehl blenden Sie das Verzeichnis /tmp/.X11-unix des "äußeren" Rechners in den chroot-Käfig ein:

root@linux# mkdir -p /test/tmp/.X11-unix
root@linux# mount --bind /tmp/.X11-unix /test/tmp/.X11-unix

Außerdem erlauben Sie Zugriff auf das Display für alle lokalen Prozesse:

user@linux> xhost + local:

Nach dem Aufruf von chroot /test setzen Sie im inneren System die DISPLAY-Variable auf :0 und können nun grafische Programme starten:

root@linux# chroot /test
root@linux# export DISPLAY=:0
root@linux# xterm

Übrigens: Eine TCP-Verbindung über localhost ist bei den meisten Distributionen aus Sicherheitsgründen per Default ausgeschaltet, sonst könnte man statt obigem Trick und den Umweg über localhost gehen. Außen xhost + localhost eingeben und innen export DISPLAY=localhost:0.



sudo mount --bind /dev ./ubuntu_flash/dev/
sudo mount --bind /sys ./ubuntu_flash/sys/ 
sudo mount --bind /proc ./ubuntu_flash/proc/

## Resizing the persistant storage of the USB stick

    resize2fs casper-rw 1024M
