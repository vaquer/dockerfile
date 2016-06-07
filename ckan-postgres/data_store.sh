#!/bin/bash
set -e

# Creacion de la BD de datastore
if [ "$POSTGRES_USER" != "$USER_DATASTORE" && "$POSTGRES_DB" != "$DATABASE_DATASTORE"]; then
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d $POSTGRES_DB <<-EOSQL
        IF NOT EXISTS (
          SELECT *
          FROM   pg_catalog.pg_user
          WHERE  usename = '$USER_DATASTORE') THEN
            CREATE USER $USER_DATASTORE;
        END IF;
        CREATE DATABASE $DATABASE_DATASTORE;
        GRANT ALL PRIVILEGES ON DATABASE $USER_DATASTORE TO $DATABASE_DATASTORE;
EOSQL
fi
