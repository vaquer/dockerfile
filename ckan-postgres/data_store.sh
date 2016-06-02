#!/bin/bash
set -e

# Creacion de la BD de datastore
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER datastore_default;
    CREATE DATABASE datastore_default;
    GRANT ALL PRIVILEGES ON DATABASE datastore_default TO datastore_default;
EOSQL