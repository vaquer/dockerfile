#!/bin/sh
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    ALTER TABLE geometry_columns OWNER TO $POSTGRES_USER;
    ALTER TABLE spatial_ref_sys OWNER TO $POSTGRES_USER;
    SELECT postgis_full_version();
EOSQL

