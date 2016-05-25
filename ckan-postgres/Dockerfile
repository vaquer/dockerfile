# Build: docker build -t mxabierto/postgres:opi 
# Usage: docker run --name postgres -e POSTGRES_USER=ckan -e POSTGRES_PASSWORD=super-secure-pass -d -P mxabierto/postgres

# Base Image
FROM postgres:9.3
MAINTAINER 	Francisco Vaquero <francisco@opi.la>

RUN \
  apt-get update && \
  apt-get install -y postgresql-9.3-postgis \
   python-dev \
   libxml2-dev \
   libxslt1-dev \
   libgeos-c1

RUN cat $POSTGRES_USER
#RUN psql --username $POSTGRES_USER -d ckan -f /usr/share/postgresql/9.3/contrib/postgis-2.2/postgis.sql
#RUN psql --username $POSTGRES_USER -d ckan -f /usr/share/postgresql/9.3/contrib/postgis-2.2/spatial_ref_sys.sql

ADD init_geospatial.sh /docker-entrypoint-initdb.d/postgis.sh
ADD data_store.sh /docker-entrypoint-initdb.d/data_store.sh
