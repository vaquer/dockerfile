# mxabierto CKAN
# Base mxabierto/ckan installation
# Heavily based on datacats ( https://github.com/datacats/datacats )
# Build:
#   docker build -t mxabierto/ckan .
# Usage:
#   docker run --rm -itP mxabierto/ckan

# Base image
FROM mxabierto/ckan
MAINTAINER Francisco Vaquero <francisco@opi.la>

# Datos para el datastore
ENV POSTGRES_ENV_POSTUSER_DATASTORE datastore_default
ENV POSTGRES_ENV_POSTPWD_DATASTORE datastore_default
ENV POSTGRES_ENV_DATABASE_DATASTORE datastore_default

# Instalacion de los plugins
# Agregar tantos como sea necesario siguiendo la estructura:
# $CKAN_HOME/bin/pip install -e git+https:repo
RUN \
  virtualenv $CKAN_HOME && \
  $CKAN_HOME/bin/pip install -e git+https://github.com/ckan/ckanext-spatial.git@stable#egg=ckanext-spatial && \
  $CKAN_HOME/bin/pip install -r $CKAN_HOME/src/ckanext-spatial/pip-requirements.txt && \
  $CKAN_HOME/bin/pip install -e git+https://github.com/opintel/ckanext-more-facets.git@test-category#egg=ckanext-more-facets && \
  $CKAN_HOME/bin/pip install -e git+https://github.com/ckan/ckanext-googleanalytics.git#egg=ckanext-googleanalytics && \
  $CKAN_HOME/bin/pip install -e git+https://github.com/ckan/ckanext-dcat.git#egg=ckanext-dcat && \
  $CKAN_HOME/bin/pip install -r $CKAN_HOME/src/ckanext-dcat/requirements.txt && \
  $CKAN_HOME/bin/pip install -e git+https://github.com/okfn/ckanext-disqus#egg=ckanext-disqus && \
  $CKAN_HOME/bin/pip install -e git+https://github.com/vaquer/ckanext-mxtheme.git#egg=ckanext-mxtheme


# Add my configuration file
ADD develop.ini /project/development.ini
ADD start.sh /start.sh

ENTRYPOINT ["/start.sh"]
