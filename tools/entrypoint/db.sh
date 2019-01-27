#!/bin/bash
set -e

echo "POSTGRES_USER: ${POSTGRES_USER}"
echo "POSTGRES_DB: ${POSTGRES_DB}"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

    CREATE USER deploy;

    CREATE DATABASE "django.retries"
        WITH
        OWNER = deploy
        ENCODING = 'UTF8'
        LC_COLLATE = 'en_US.UTF-8'
        LC_CTYPE = 'en_US.UTF-8'
        TEMPLATE = template0
        TABLESPACE = pg_default
        CONNECTION LIMIT = -1;

    GRANT ALL PRIVILEGES ON DATABASE "django.retries" TO deploy;

EOSQL