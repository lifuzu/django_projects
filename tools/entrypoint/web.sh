#!/bin/bash
set -e

# Wait for Postgres Started
if [ "${DB_KIND}" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z "${DB_HOST}" "${DB_PORT}"; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

# DB migration
python manage.py flush --no-input
python manage.py migrate
# Fill in fixture data
python manage.py loaddata retries

# Setting up static resource folder
python manage.py collectstatic --no-input

exec "$@"