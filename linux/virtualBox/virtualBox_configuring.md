
# VirtualBox Configuring Howto

## Booting from USB stick (Linux)

    sudo fdisk -l
    # /dev/sdc is the device with the USB-Stick
    
    VBoxManage internalcommands createrawvmdk -filename ~/.VirtualBox/HardDisks/usb.vmdk -rawdisk /dev/sdc 
    
    # on some systems you need to type: VBoxManage internalcommands createrawvmdk -filename ~/.VirtualBox/HardDisks/usb.vmdk -rawdisk /dev/sdb -register

    # if the HardDisks directory is missing, do not forget to create it:
    mkdir ~/.VirtualBox/HardDisks/
    
    # Sometimes you need to give special permissions ...
    sudo chmod 666 /dev/sdc*
    sudo chown `whoami` ~/.VirtualBox/HardDisks/usb.vdmk
    
When creating a new VM, just point Harddrive to existing drive: __~/.VirtualBox/HardDisks/usb.vdmk__
    
## Booting from USB stick (Windows)

Open an admin console and type:

    cd %programfiles%\Oracle\VirtualBox
        
    VBoxManage internalcommands createrawvmdk -filename C:\usb.vmdk -rawdisk \\.\PhysicalDrive#
    # is the Disk Number (s. Disk Manager)
    
    


 
