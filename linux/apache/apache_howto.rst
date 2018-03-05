
Apache Webserver howto
======================



set server name
_______________

1. create config file
    sudo vim /etc/apache2/conf-available/servername.conf

1. add to file:
   ServerName localhost

1. enable config by 
    sudo a2enconf servername
    


Working setup method for Apache 2.4
___________________________________

s. https://wiki.ubuntuusers.de/Apache_2.4/


1. check, if localhost is resolvable through /etc/hosts

    127.0.0.1 localhost
    
1. create system group www, if not already present

    sudo addgroup --system  www
    sudo addgroup [your-username] www-data

1. select a directory for media content

1. change group for this directory

    sudo chgrp -R www .
    
1. add config file in /etc/apache2/config-available

    django-media.conf

with following content

    Alias "/media" "/path/to/media"
    <Directory "/path/to/media">
      Require all granted
      # set, if only allowed from localhost:
      # Allow from localhost
    </Directory>

1. activate config

    sudo a2enconf django-media

1. restart apache2

    sudo service apache2 reload
    

It is also possible to define virtual hosts:

s. 

https://wiki.ubuntuusers.de/Apache/Virtual_Hosts/

and

http://httpd.apache.org/docs/2.4/de/vhosts/
