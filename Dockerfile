########################################################################
# Modified elasticsearch container with searchguard TLS
########################################################################
# Base Image #
FROM docker.elastic.co/elasticsearch/elasticsearch:6.4.2

#####################
# Labels
#####################
LABEL Maintainer.email="silvertear33@yahoo.com" \
      Maintainer.name="Taylor Ashworth" \
      Version="6.4.2"

#####################
# Setup
#####################
USER root
RUN mkdir /usr/share/elasticsearch/config/certs

COPY files/search-guard-ssl-6.4.2-25.zip /tmp/

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install -b file:///tmp/search-guard-ssl-6.4.2-25.zip && \
  rm /tmp/search-guard-ssl-6.4.2-25.zip && \
  yum -y install apr

RUN usermod -u 45113 elasticsearch && \
  groupmod -g 45119 elasticsearch
#####################
# Volumes
#####################

### Volumes to be mounted to docker volumes/host mounts ###
VOLUME /usr/share/elasticsearch/data


# setting run user to elasticsearch #
USER elasticsearch
