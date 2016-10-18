linux shell scripts how-tos
===========================

Fast file editing
_________________


substitute
----------

most simple replacement:

    sed 's/day/night/' old >new

removing something and print:

    sed  's/'$target_spec_dir'//p' 

multiple substitutions with one sed command

    sed -i "s/MDO_growth_//; s/_OD600.*/ /" *.DAT 

remove MDO_varioskan_ and _ from MDO_varioskan_0638_

    sed "s/MDO_varioskan_//; s/_\s/  /" 

    -i : in-place edit

    echo "This is just a test" | sed -e 's/ /_/g' -> This_is_just_a_test


Mass Renaming files
___________________

    apt-get install rename
    rename s/SPabsMW/SPabs/ *.DAT 


removing 
_________

    rm $(ls -t | awk 'NR>4') 

    for dirs in `ls -1 .`; do echo "entering" $dirs "now removing"; cd $dirs; rm $(ls -t | awk 'NR>4'); cd .. ; done 

Removing first/last n files of dir
----------------------------------

    for dirs in `ls -1 .`;do  bash /datalin/data/mark/source/sh/evaluate_growth_experiments_varioskan.sh $dirs; echo $dirs; done 

Commandline parsing
___________________

Using getopt[s]
---------------

from: http://mywiki.wooledge.org/BashFAQ/035#getopts

Never use getopt(1). getopt cannot handle empty arguments strings, or arguments with embedded whitespace. Please forget that it ever existed.

The POSIX shell (and others) offer getopts which is safe to use instead. Here is a simplistic getopts example:

#!/bin/sh

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
output_file=""
verbose=0

while getopts "h?vf:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    v)  verbose=1
        ;;
    f)  output_file=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

echo "verbose=$verbose, output_file='$output_file', Leftovers: $@"

# End of file
The advantages of getopts are:

It's portable, and will work in e.g. dash.
It can handle things like -vf filename in the expected Unix way, automatically.
The disadvantage of getopts is that it can only handle short options (-h, not --help) without trickery.

There is a getopts tutorial which explains what all of the syntax and variables mean. In bash, there is also help getopts, which might be informative.



Straight Bash Space Separated
-----------------------------

Usage   ./myscript.sh -e conf -s /etc -l /usr/lib /etc/hosts 

#!/bin/bash
# Use -gt 1 to consume two arguments per pass in the loop (e.g. each
# argument has a corresponding value to go with it).
# Use -gt 0 to consume one or more arguments per pass in the loop (e.g.
# some arguments don't have a corresponding value to go with it such
# as in the --default example).
# note: if this is set to -gt 0 the /etc/hosts part is not recognized ( may be a bug )
while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -e|--extension)
    EXTENSION="$2"
    shift # past argument
    ;;
    -s|--searchpath)
    SEARCHPATH="$2"
    shift # past argument
    ;;
    -l|--lib)
    LIBPATH="$2"
    shift # past argument
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done
echo FILE EXTENSION  = "${EXTENSION}"
echo SEARCH PATH     = "${SEARCHPATH}"
echo LIBRARY PATH    = "${LIBPATH}"
echo "Number files in SEARCH PATH with EXTENSION:" $(ls -1 "${SEARCHPATH}"/*."${EXTENSION}" | wc -l)


Straight Bash Equals Separated
-------------------------------

#!/bin/bash

for i in "$@"
do
case $i in
    -e=*|--extension=*)
    EXTENSION="${i#*=}"
    shift # past argument=value
    ;;
    -s=*|--searchpath=*)
    SEARCHPATH="${i#*=}"
    shift # past argument=value
    ;;
    -l=*|--lib=*)
    LIBPATH="${i#*=}"
    shift # past argument=value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument with no value
    ;;
    *)
            # unknown option
    ;;
esac
done
echo "FILE EXTENSION  = ${EXTENSION}"
echo "SEARCH PATH     = ${SEARCHPATH}"
echo "LIBRARY PATH    = ${LIBPATH}"
echo "Number files in SEARCH PATH with EXTENSION:" $(ls -1 "${SEARCHPATH}"/*."${EXTENSION}" | wc -l)
if [[ -n $1 ]]; then
    echo "Last line of file specified as non-opt/last argument:"
    tail -1 $1
fi
To better understand ${i#*=} search for "Substring Removal" in this guide. It is functionally equivalent to `sed 's/[^=]*=//' <<< "$i"` which calls a needless subprocess or `echo "$i" | sed 's/[^=]*=//'` which calls two needless subprocesses.



Multithreading in loops
_______________________

example:
for meas_file in $(ls -1 *.dat);  do ( Rscript  meas_eval.R --filename=$meas_file ) & done 


Finding Duplicates
___________________

1.

    find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate 

Find Duplicate Files (based on size first, then MD5 hash) 
This dup finder saves time by comparing size first, then md5sum, it doesn't delete anything, just lists them. 

2.
    find -type f -exec md5sum '{}' ';' | sort | uniq --all-repeated=separate -w 33 | cut -c 35- 

3. Find Duplicate Files (based on MD5 hash) 
Calculates md5 sum of files. sort (required for uniq to work). uniq based on only the hash. use cut ro remove the hash from the result. 

    find -type d -name ".svn" -prune -o -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type d -name ".svn" -prune -o -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate 

Find Duplicate Files, excluding .svn-directories (based on size first, then MD5 hash) 
Improvement of the command "Find Duplicate Files (based on size first, then MD5 hash)" when searching for duplicate files in a directory containing a subversion working copy. This way the (multiple dupicates) in the meta-information directories are ignored. 
Can easily be adopted for other VCS as well. For CVS i.e. change ".svn" into ".csv": 
find -type d -name ".csv" -prune -o -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type d -name ".csv" -prune -o -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate 


4.

    find -not -empty -type f -printf "%-30s'\t\"%h/%f\"\n" | sort -rn -t$'\t' | uniq -w30 -D | cut -f 2 -d $'\t' | xargs md5sum | sort | uniq -w32 --all-repeated=separate 

Find Duplicate Files (based on size first, then MD5 hash) 

Finds duplicates based on MD5 sum. Compares only files with the same size. Performance improvements on: 

    find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate 

The new version takes around 3 seconds where the old version took around 17 minutes. The bottle neck in the old command was the second find. It searches for the files with the specified file size. The new version keeps the file path and size from the beginning. 

5.
    find . -type f -exec md5 '{}' ';' | sort | uniq -f 3 -d | sed -e "s/.*(\(.*\)).*/\1/" 

Find Duplicate Files (based on MD5 hash) -- For Mac OS X 
This works on Mac OS X using the `md5` command instead of `md5sum`, which works similarly, but has a different output format. Note that this only prints the name of the duplicates, not the original file. This is handy because you can add `| xargs rm` to the end of the command to delete all the duplicates while leaving the original. 

6.
    fdupes -r . 

Find Duplicate Files (based on size first, then MD5 hash) 

If you have the fdupes command, you'll save a lot of typing. It can do recursive searches (-r,-R) and it allows you to interactively select which of the duplicate files found you wish to keep or delete. 

7. fslint (GUI tool)


Patches
________


HOW TO CREATE PATCH FILE USING PATCH AND DIFF

First, how to create patch file?

Patch file is a readable file that created by diff with -c (context output format). It doesn’t matter and if you wanna know more, man diff. To patch the entire folder of source codes(as usually people do)I do as bellow:
Assume Original source code at folder Tb01, and latest source code at folder Tb02. And there have multiple sub directories at Tb01 and Tb02 too.

    diff -crB Tb01 Tb02 > Tb02.patch

    -c context, -r recursive (multiple levels dir), -B is to ignore Blank Lines. 

I put -B because blank lines is really useless for patching, sometimes I need to manually read the patch file to track the changes, without -B is really headache. 

How to patch?
______________


First of all, please do a dry-run before really patch it. Bare in mind, patch will be working very specifically. Let say the version 3 Tb03.patch is use to patch from Tb02, if you apply patch on Tb01, sometimes it will corrupt your source code. So, to make sure it works, do a dry run. Dry-run means a fake-test, do it at the directory of the source code targeted to patch. 
Doing dry-run like this: 

patch --dry-run -p1 -i Tb02.patch 

The success output looks like this: 
patching file TbApi.cpp 
patching file TbApi.h 
patching file TbCard.cpp 
... 
The failure ouptut looks like this: 
patching file TbCard.cpp 
Hunk #2 FAILED at 585. 
1 out of 2 hunks FAILED -- saving rejects to file TbCard.cpp.rej 
patching file TbCard.h 
Hunk #1 FAILED at 57. 
Hunk #2 FAILED at 77. 
Hunk #3 succeeded at 83 with fuzz 1 (offset -21 lines). 
.... 

At last, if the dry-run is giving good result, do this and enjoy the compilation. 

patch -p1 -i Tb02.patch 

Mounting a WebDAV directory in Linux (Ubuntu)
_____________________________________________

In this way you don't need to use terminal all the time to mount/umount a WebDav directory as nautilus  can be used easily. The steps are as follows.

1. Install davfs
2 # sudo apt-get install davfs2 Reconfigure davfs2 to enable to use davfs under unprivileged users # sudo dpkg-reconfigure davfs2 Edit /etc/davfs2/davfs2.conf to enable automatic credentials use.  Uncomment the line secrets ~/.davfs2/secrets Edit ~/.davfs2/secrets file to add credentials to remote WebDav diectory. Add a line to the end of file in following style: https://<WebDav URI>   <username> <password> Set the permission:  # chmod 600 ~/.davfs2/secrets Add a line to /ect/fstab about the remote WebDav directory https://<WebDav URI> <mount point> davfs user,noauto,file_mode=600,dir_mode=700 0 1 Add your user to the davfs2 group # sudo vi /etc/group Add your username as follows: davfs2:x:134:<username> That's it. You can use following commands without being a root user to mount/umount # mount <mount point> # umount <mount point> You can also use nautilus to mount/umount the directory. 

Watching changes during installation
____________________________________

s. http://linux.die.net/man/1/inotifywatch

    sudo inotifywait -r  -m -e create /home/mark /tmp /usr /opt /lib /lib64 /lib32 /var /root > genious618_installation_140627_actserv.txt 

    inotifywatch - gather filesystem access statistics using inotify


You can use inotify directly from command line, e.g. like this:

    inotifywait -r  -m $HOME

And here is a script that monitors continously, copied from the man file of inotifywait:

#!/bin/sh
while inotifywait -e modify /var/log/messages; do
  if tail -n1 /var/log/messages | grep httpd; then
    kdialog --msgbox "Apache needs love!"
  fi
done
