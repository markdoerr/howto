
# USB boot stick

s. 
https://tecadmin.net/how-to-create-bootable-linux-usb-drive-from-linux-terminal/



Q. How do I create bootable Linux USB drive on Linux system. 

I want to create of bootable us of Ubuntu 14.04 LTS. I have an Ubuntu 14.04 ISO image. I also have Ubuntu 14.04 installed on my system. 
Now, This article will help you to create bootable Linux USB drive on Linux operating system through the command line.

Step to Create Bootable Linux USB:

Follow the below steps to make bootable Linux USB
        
        Install Required Package – First of all, install all the required packages for this tutorial using the following command.

        $ sudo apt-get install syslinux mtools

        Mount ISO – Now, create a mount point on your system and mount Linux ISO image using the following command. For example, I used Ubuntu14.04.iso image and /media/iso as mountpoint.

        $ sudo mkdir /media/iso
        $ sudo mount -o loop /opt/Ubuntu14.04.iso /media/iso

        Attach USB – Now attach your USB drive to your computer to which you need to make bootable. Generally, the USB mounts automatically. But in any case, it’s not mounted using the following command to mount it manually.

        $ sudo mount /dev/sdc /media/usb

        Read this: How To Format USB Drive in Linux Command Line
        Copy OS Files – Now copy all files from mounted iso /media/iso/ to USB drive /media/usb.

        $ sudo cp -ra /media/iso/* /media/usb

        Make USB Bootable – Finally, we need to make this USB bootable. Copy ldlinux.sys file to USB drive to make it bootable.

        $ sudo syslinux -s /dev/sdd1

        Now rename some required files and directories as like below. Navigate to USB drive

        $ cd /media/usb
        $ mv isolinux syslinux
        $ cd syslinux
        $ mv isolinux.cfg syslinux.cfg

    And, you have all done. Your USB flash drive is ready. Now you can connect this USB to a computer which you need to install Linux operating system and boot it from USB.

further info:

https://www.linuxquestions.org/questions/linux-general-1/how-to-make-a-bootable-usb-flash-drive-manually-859334/




    How to Create Ubuntu Bootable USB in Windows
    
    The users running the Windows operating system visit the below link to make bootable Linux USB on their system.

https://www.pendrivelinux.com/universal-usb-installer-easy-as-1-2-3/
