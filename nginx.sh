#!/bin/sh

# Start nginx and php
/usr/sbin/php-fpm7 &
/usr/sbin/nginx &

tail -f /var/log/nginx/access.log /var/log/nginx/error.log