
# Raspberry PI as PXE server

## installation required packages

apt-get update && apt-get install isc-dhcp-server tftpd-hpa && syslinux-common


## DHCP server configuration

/etc/dhcp/dhcp.config
add


/etc/default/isc-dhcp-server

add:
INTERFACESv4="eth0"

!! it is important to assign a valid ip to eth0 : 
sudo ifconfig eth0 10.0.0.3

it is very important to stop the default DHCP Client Daemon (DHCPCD) by
sudo service dhcpcd stop

then start isc-dhcp-server

sudo service isc-dhcp-server restart

check status:
sudo service isc-dhcp-server status


### check, if server is running
pgrep -lf dhcpd

## TFP-server

in 

/etc/default/tftpd-hpa
add:

TFTP_OPTIONS="--secure --ipv4"

### checking, if running
pgrep -lf tftpd

## syslinux

sudo cp /usr/lib/syslinux/chain.c32 /usr/lib/syslinux/menu.c32 /usr/lib/syslinux/vesamenu.c32 /usr/lib/syslinux/pxelinux.0 /srv/tftp/


download a netboot image (corresp. to target system)

http://de.archive.ubuntu.com/ubuntu/dists/xenial/main/installer-i386/current/images/netboot/netboot.tar.gz



## troubleshooting

check listening ports on server


sudo netstat -plnt
