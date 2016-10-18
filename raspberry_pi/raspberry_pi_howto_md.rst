
Raspberry Pi howto
==================


Setup Pi Camera
_______________

1. connect


    sudo apt-get update && sudo apt-get upgrade

    sudo raspi-config

First select 'Advanced > Memory_split' - it should be set to 128 already, but if not, then make the change. The camera system seemed to work fine set to 16, but the recommendation is 128.

Error : ENOSPC. The Camera Module is probably running out of GPU memory. Check config.txt in the /boot/ folder. The gpu_mem option should be at least 128. Alternatively, use the Memory Split option in the Advanced section of raspi-config to set this.


Finally, there's the Enable/Disable Camera support option: select this and choose Enable. Select Finish and choose to Reboot.


raspistill -v -o test.jpg

in case of ENSPC error a firmware update might help:
    sudo rpi-update


Taking photos with the Raspberry Pi
-----------------------------------

Two command-line tools are provided to access the camera module - these are raspivid and raspistill. Open a terminal and run either to see a list of available commands (or the original documentation is here).

The following are terminal commands and what they'll do, the default capture time is 5 seconds, use the -t control to specify a longer period in milliseconds, so -t 20000 for 20 seconds.

Display a five-second demo: 
    raspivid -d

Display a 640x480 preview: 
    raspivid -p 0,0,640,480

Capture 20s of h264 video: 
    raspivid -t 20000 -o video.h264

Take a 640x480 shot: 
    raspistill -o image.jpg -w 640 -h 480

Take a reduced quality JPEG: 
    raspistill -o image.jpg -q 5

The camera offers a good range of image effects and general camera options, which can be applied live to both the still and video images. You're able to alter white balance modes, focusing metering, shot type, exposure, ISO levels and EXIF data.



Simple network streaming
------------------------

You can fire a video stream from the Raspberry Pi over your network, using the standard raspivid output piped through the general-purpose netcat network command. The terminal command line below will do just that:

raspivid -t 99999 -o - | nc [ip of target computer] 5001

If you're on a Linux system then this is easy enough to receive by running the following command:

nc -l 5001 | mplayer -fps 31 -cache 1024 -

troubleshooting
---------------
s. https://www.raspberrypi.org/documentation/raspbian/applications/camera.md

s. http://www.techradar.com/news/computing-components/peripherals/how-to-install-the-raspberry-pi-camera-module-1172034


