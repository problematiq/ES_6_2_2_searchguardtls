########################################################################
# Modified elasticsearch container with searchguard TLS
########################################################################
# Base Image #
FROM docker.elastic.co/elasticsearch/elasticsearch:6.2.2

#####################
# Labels
#####################
LABEL Maintainer.email="silvertear33@yahoo.com" \
      Maintainer.name="Taylor Ashworth" \
      Version="6.2.2"

#####################
# Setup
#####################

# Installing ssl-guard for api encryption #
USER root
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install -b com.floragunn:search-guard-ssl:6.2.2-25.1 \
  && yum -y install wget \
  apr \
  && mkdir /usr/share/elasticsearch/config/certs \
  && cd /usr/share/elasticsearch/plugins/search-guard-ssl/ \
  && wget https://bintray.com/floragunncom/netty-tcnative/download_file?file_path=netty-tcnative-openssl-1.0.2-dynamic-2.0.1.Final-fedora-linux-x86_64.jar

# setting run user to elasticsearch #
USER elasticsearch
