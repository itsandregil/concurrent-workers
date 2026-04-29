#!/bin/sh

echo "Waiting for DB..."
until nc -z db 5432; do
  sleep 1
done

echo "Running migrations..."
goose -dir ./sql/schema postgres "$DATABASE_URL" up || exit 1

echo "Starting worker..."
exec ./worker
