#!/bin/sh
set -e

chown -R www-data:www-data /var/www/html/storage || true
chown -R www-data:www-data /var/www/html/bootstrap/cache || true

exec apache2-foreground
