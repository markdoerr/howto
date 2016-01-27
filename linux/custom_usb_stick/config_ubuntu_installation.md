

# howto describing the procedure to generate a custom ubuntu system
    last modified: 150517
    
## preperations

    consider to partition the usb stick to max 32GB

    sudo mkdir /mnt/ubuntu_flash/
    sudo mount -o loop /home/mark/temp/custom_mint/filesystem.squashfs /mnt/ubuntu_flash/

    sudo mkdir /home/mark/temp/custom_mint/squashfs
    export mint172=/home/mark/temp/custom_mint/squashfs

    sudo cp -a /mnt/ubuntu_flash/* $mint172/
    sudo umount /mnt/ubuntu_flash

    sudo mount --rbind /dev $mint172/dev/
    sudo mount --rbind /sys $mint172/sys/
    sudo mount --rbind /proc $mint172/proc/

    sudo cp /etc/resolv.conf $mint172/etc/

# place policy-rc.d in parent directory
    sudo cp policy-rc.d $mint172/usr/sbin/
    sudo chmod a+x $mint172/usr/sbin/policy-rc.d

# X11 setup

    sudo mkdir -p $mint172/tmp/.X11-unix
    sudo mount --rbind /tmp/.X11-unix $mint172/tmp/.X11-unix/

    sudo xhost + local:
    sudo xhost + localhost

# cp all required files to new file system
    sudo mkdir squashfs/home/to_inst
    sudo cp ./truecrypt-7.1a-setup-x64 $mint172/home/to_inst
    sudo cp ./install_useful_packages.sh $mint172/home/to_inst
    sudo cp -a Gimp-painter\ Brush\ Kit/ $mint172/home/to_inst
    
# now changing root

    sudo chroot $mint172

    export DISPLAY=:0 ;     dpkg-divert --local --rename --add /sbin/initctl ;  ln -s /bin/true /sbin/initctl

## ... makeing changes ...

    # before installation, please update
    apt-get update

## installation new packages 
  s. linux-mint/linux_mint.txt

when ready:
    
    # check if user 999 exists, if yes, remove with usermod -u 500 $hit
    awk -F: '$3 == 999' /etc/passwd

    apt-get clean;  apt-get autoclean ; apt-get autoremove; rm -rf /tmp/*

    rm /var/lib/dbus/machine-id ; rm /sbin/initctl ; dpkg-divert --rename --remove /sbin/initctl ; rm -R /home/mark; 
    umount /proc || umount -lf /proc ; umount /sys ;umount /dev/pts   ;exit

    #sudo rm -f $mint172/etc/resolv.conf

    sudo umount -l  $mint172/tmp/.X11-unix/; sudo umount  -l  $mint172/sys/ ; sudo umount -l  $mint172/proc/ ; sudo umount  -l $mint172/dev/

    sudo mv $mint172/usr/sbin/policy-rc.d $mint172/usr/sbin/policy-rc.d_disa


    mv filesystem.squashfs filesystem.squashfs_orig
 
    sudo mksquashfs $mint172 filesystem.squashfs
    #sudo mksquashfs $mint172 filesystem.squashfs -wildcards -e boot/vmlinuz-* boot/initrd.img-*

    # this is required by the installer
    printf $(sudo du -sx --block-size=1 $mint172 | cut -f1) > filesystem.size
    sudo cp filesystem.size /media/mark/MINTUSB/casper; sudo cp filesystem.squashfs /media/mark/MINTUSB/casper
    
    
    # copy kernel and inird
     sudo cp $mint172/boot/vmlinuz-3.13.0-37-generic /media/mark/MINTUSB/casper/vmlinuz
     sudo cp $mint172/boot/initrd.img-3.13.0-37-generic /media/mark/MINTUSB/casper/initrd.lz
     # or .lz (check type)

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

## booting USB stick with Virtual Box
 s. Virtual-box how-to

## Resizing the persistant storage of the USB stick

    resize2fs casper-rw 1024M
