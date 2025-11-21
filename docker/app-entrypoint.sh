#!/bin/sh
set -e

APP_DIR=/var/www/html
cd "$APP_DIR"

chown -R www-data:www-data "$APP_DIR/storage" || true
chown -R www-data:www-data "$APP_DIR/bootstrap/cache" || true

if [ ! -f "$APP_DIR/vendor/autoload.php" ]; then
  composer install --no-dev --prefer-dist --no-interaction
fi

if [ -z "$APP_KEY" ] || [ "$APP_KEY" = "" ]; then
  php artisan key:generate
fi

php -r '
$h=getenv("DB_HOST")?:"db"; $p=(int)(getenv("DB_PORT")?:5432);
$db=getenv("DB_DATABASE")?:"tinder_clone"; $u=getenv("DB_USERNAME")?:"postgres"; $pw=getenv("DB_PASSWORD")?:"";
$dsn = "pgsql:host=".$h.";port=".$p.";dbname=".$db;
for($i=0;$i<60;$i++){try{new PDO($dsn,$u,$pw);exit(0);}catch(Exception $e){usleep(500000);} }
exit(1);
'

php artisan migrate --force || true
php artisan db:seed --force || true

exec apache2-foreground
