#!/bin/bash

RESULT=`/usr/local/bin/docker-compose run certbot /certbot/certbot-auto renew --webroot --webroot-path=/var/letsencrypt`

if [ -n "`echo \"$RESULT\" | grep 'heine7\.de.*success'`" ]
then
  echo certs updated
  /usr/local/bin/docker-compose kill -s HUP dovecot
  /usr/local/bin/docker-compose kill -s HUP nginx
fi
