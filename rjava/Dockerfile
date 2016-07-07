FROM rocker/r-base

ENV DBUILD_OPENJDK_VERSION 8u72-b05-6
#8u72-b15-1~bpo8+1
ENV DBUILD_CA_CERTIFICATES_JAVA_VERSION 20140324

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JAVA_VERSION 8u72

RUN \
  # We need to add OpenJDK's backport repository to find their Java 8.
  echo 'deb http://httpredir.debian.org/debian jessie-backports main' > \
  /etc/apt/sources.list.d/jessie-backports.list \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    openjdk-8-jdk="$DBUILD_OPENJDK_VERSION" \
    ca-certificates-java="$DBUILD_CA_CERTIFICATES_JAVA_VERSION" \
    libxml2-dev \
    libcurl4-gnutls-dev &&\
    rm /etc/apt/sources.list.d/jessie-backports.list &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    R CMD javareconf &&\
    R --no-save--no-save -e "install.packages( c('rJava',\
    'XML', \
    'RCurl', \
    'lubridate', \
    'stringdist', \
    'plyr', \
    'dplyr', \
    'tidyr', \
    'data.table', \
    'DT', \
    'ggplot2', \
    'gdata', \
    'readxl', \
    'xlsx', \
    'shinydashboard', \
    'jsonlite'), \
     repos='https://cran.rstudio.com/', \
     configure.args='--disable-Xrs')"
