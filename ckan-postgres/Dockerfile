# Build: docker build -t mxabierto/postgres:opi 
# Usage: docker run --name postgres -e POSTGRES_USER=ckan -e POSTGRES_PASSWORD=super-secure-pass -d -P mxabierto/postgres

# Base Image
FROM postgres:9.3
MAINTAINER 	Francisco Vaquero <francisco@opi.la>

# Se instalan las dependencias para tener postgis en postgres
RUN \
  apt-get update && \
  apt-get install -y postgresql-9.3-postgis \
   python-dev \
   libxml2-dev \
   libxslt1-dev \
   libgeos-c1

#Rutina para iniciar tablas geospaciales
ADD init_geospatial.sh /docker-entrypoint-initdb.d/postgis.sh
#Rutina para habilitar el datastore
ADD data_store.sh /docker-entrypoint-initdb.d/data_store.sh
