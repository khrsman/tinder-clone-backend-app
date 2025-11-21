Laravel backend for a Tinder-like app.

Running the app

1) With Docker
- Prerequisites
  - Docker & Docker Compose

- Steps:
- Build and start:
```bash
docker compose down -v
docker compose up -d --build
```
- The `app` container will automatically:
  - install dependencies (run `composer install` if vendor missing)
  - generate `APP_KEY`
  - wait for the DB to be ready
  - run `php artisan migrate --force` and `php artisan db:seed --force`

Notes
- To re-initialize from scratch: `docker compose down -v` then start again.
- DB config in compose: host `db`, port `5432`, database `tinder_clone`, user `postgres`, password as in `docker-compose.yml`.



2) Without Docker
- Requirements:
  - PHP 8.1+
  - Composer
  - PostgreSQL (or adjust `.env` for your DB)
- Steps:
```bash
composer install
php artisan key:generate

# configure DB connection in .env (DB_HOST, DB_PORT, DB_DATABASE, DB_USERNAME, DB_PASSWORD)
php artisan migrate --force
php artisan db:seed --force

# start local server
php artisan serve
```



Main endpoints
- Swagger UI: `http://127.0.0.1:8000/docs/`
- People:
  - `GET /api/people?min_age=&max_age=&max_distance=&per_page=`
- Likes:
  - `GET /api/likes?user_id=1&status=like&per_page=20`
  - `POST /api/likes` body `{"user_id":1,"people_id":3,"status":"like"}`
  - `POST /api/likes/rewind` body `{"user_id":1}`

Cron testing (Popular People - More than 50 Likes)
- Run manually without cron:
  - Without Docker:
    ```bash
    php artisan popular:check --threshold=50 --notify=khrsman@yopmail.com
    ```
  - With Docker:
    ```bash
    docker compose exec app php artisan popular:check --threshold=50 --notify=khrsman@yopmail.com
    ```

Email setup (Gmail SMTP)
- Ensure SMTP env is configured before running the command:
```
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your@gmail.com
MAIL_PASSWORD=your-app-password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=your@gmail.com
MAIL_FROM_NAME="Tinder Clone"
```
- For testing without SMTP, set `MAIL_MAILER=log` to write emails to `storage/logs/laravel.log`.
