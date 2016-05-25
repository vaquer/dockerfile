#!/bin/bash
set -e

psql --username $POSTGRES_USER -d ckan -f /usr/share/postgresql/9.3/contrib/postgis-2.2/postgis.sql
psql --username $POSTGRES_USER -d ckan -f /usr/share/postgresql/9.3/contrib/postgis-2.2/spatial_ref_sys.sql

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER datastore_default;
    CREATE DATABASE datastore_default;
    GRANT ALL PRIVILEGES ON DATABASE datastore_default TO datastore_default;
EOSQL