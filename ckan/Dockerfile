# mxabierto CKAN
# Base ckan installation
# Heavily based on datacats ( https://github.com/datacats/datacats )
# Build:
#   docker build -t mxabierto/ckan .
# Usage:
#   docker run --rm -itP mxabierto/ckan

# Base image
FROM ubuntu:16.04

MAINTAINER bcessa <ben@pixative.com>

# Configuration variables
ENV CKAN_HOME /usr/lib/ckan
# ENV BRANCH dev-v2.6
# ENV BRANCH release-v2.6-latest
ENV BRANCH ckan-2.7.3
ENV INIT_DBS true

# Locale setup
# RUN \
#   locale-gen en_US.UTF-8 && \
#   echo 'LANG="en_US.UTF-8"' > /etc/default/locale

# Install dependencies
RUN \
  DEBIAN_FRONTEND=noninteractive \
  apt-get update && \
  apt-get install -y  python-dev postgresql libpq-dev python-pip python-virtualenv\
    apache2 libapache2-mod-wsgi libapache2-mod-rpaf \
    build-essential \
    curl \
    gdal-bin \
    git-core \
    libpq-dev \
    wget && \
  apt-get clean && \
  apt-get autoclean && \
  apt-get autoremove && \
  rm -rf /var/lib/apt/lists/*


# Configure webserver
ADD apache.wsgi /etc/ckan/apache.wsgi
ADD ckan_default.conf /etc/apache2/sites-available/ckan_default.conf
ADD ports.conf /etc/apache2/ports.conf
RUN \
  a2ensite ckan_default && \
  a2dissite 000-default && \
  a2enmod headers && \
  mkdir -p /var/www/storage && \
  chown -R www-data:www-data /var/www/ && \
  usermod -u 1000 -d /var/www/storage www-data

# Install CKAN
RUN \
  virtualenv $CKAN_HOME && \
  mkdir -p $CKAN_HOME /project /var/www/storage && \
  chown -R www-data:www-data /var/www && \
  #git clone --depth 1 --branch $BRANCH https://github.com/ckan/ckan /project/ckan && \
  git clone --depth 1 --branch $BRANCH https://github.com/ckan/ckan /project/ckan && \
  #git clone --depth 1 --branch stable https://github.com/ckan/datapusher /project/datapusher && \
  $CKAN_HOME/bin/pip install -U setuptools==36.1 && \
  $CKAN_HOME/bin/pip install -r /project/ckan/requirements.in && \
  $CKAN_HOME/bin/pip install -e /project/ckan && \
  $CKAN_HOME/bin/pip install ckanapi && \
  #$CKAN_HOME/bin/pip install -r /project/datapusher/requirements.txt && \
  # Create sample configuration file
  $CKAN_HOME/bin/paster make-config ckan /project/development.ini && \
  wget -O /project/who.ini https://raw.githubusercontent.com/ckan/ckan/master/ckan/config/who.ini

# HTTP port
EXPOSE 5000

# Entry point
ADD start.sh /start.sh

# User
RUN groupadd -r ckan && useradd -r -g ckan ckan
ENTRYPOINT ["/start.sh"]
