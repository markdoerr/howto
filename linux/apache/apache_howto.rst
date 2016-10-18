
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
    
