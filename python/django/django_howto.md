# Django how-to

## Deploying django

### setup virtualenv

    pip install virtualenv virtualenvwrapper
    export WORKON_HOME=~/Envs
    source /usr/local/bin/virtualenvwrapper.sh

    # Create a virtual environment:
    $ mkvirtualenv venv
This creates the venv folder inside ~/Envs.

Work on a virtual environment:
    $ workon venv
virtualenvwrapper provides tab-completion on environment names. It really helps when you have a lot of environments and have trouble remembering their names.

workon also deactivates whatever environment you are currently in, so you can quickly switch between environments.

Deactivating is still the same:
    $ deactivate
To delete:
    $ rmvirtualenv venv

### freezing venv requirements
pip freeze > lara_venv_requirements.txt

## Apache2 and mod_wsgi

 - check, if mod_sgi is enabled in /etc/apache2/mods-enabled
 sudo chmod a+x django.wsgi

### Apache config (https://docs.djangoproject.com/en/1.7/howto/deployment/wsgi/modwsgi/)

    Alias /robots.txt /path/to/mysite.com/static/robots.txt
    Alias /favicon.ico /path/to/mysite.com/static/favicon.ico

    Alias /media/ /path/to/mysite.com/media/ 
    Alias /static/ /path/to/mysite.com/static/

    <Directory /path/to/mysite.com/static>
      Require all granted
    </Directory>

    <Directory /path/to/mysite.com/media>
    Require all granted
    </Directory>

    WSGIScriptAlias / /path/to/mysite.com/mysite/wsgi.py

    <Directory /path/to/mysite.com/mysite>
    <Files wsgi.py>
    Require all granted
    </Files>
    </Directory>


### smtpd error
    python -m smtpd -n -c DebuggingServer localhost:1025
 # md added: please correct to right backend s. https://docs.djangoproject.com/en/1.7/topics/email/
    EMAIL_BACKEND = 'django.core.mail.backends.dummy.EmailBackend'


