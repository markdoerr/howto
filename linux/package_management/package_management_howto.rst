
list all installed  packages

dpkg-query -l

sudo dpkg --get-selections

To see all the files the package installed onto your system, do this:

dpkg-query -L <package_name>
To see the files a .deb file will install

dpkg-deb -c <package_name.deb>
To see the files contained in a package NOT installed, do this once (if you haven't installed apt-file already:

sudo apt-get install apt-file
sudo apt-file update
then

apt-file list <package_name>


Use --contents instead of -L:

dpkg --contents PACKAGENAME
When used in this manner, dpkg acts as a front-end to dpkg-deb, so use man dpkg-deb to see all the options.
