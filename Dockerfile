# Dockerfile for Event Store 3.0.3 on Debian
FROM debian:jessie
MAINTAINER Héctor Ramón <hector0193@gmail.com>

ENV ES_VERSION 3.0.3

# Install wget
RUN apt-get update && apt-get install -y curl wget

# Downloads Event Store
RUN wget http://download.geteventstore.com/binaries/EventStore-OSS-Linux-v$ES_VERSION.tar.gz && \
    tar -xvzf EventStore-OSS-Linux-v$ES_VERSION.tar.gz && \
    rm EventStore-OSS-Linux-v$ES_VERSION.tar.gz && \
    mv EventStore-OSS-Linux-v$ES_VERSION EventStore

# Add entrypoint script
ADD event_store.sh .

VOLUME /var/opt/EventStore

EXPOSE 2113
EXPOSE 1113

ENTRYPOINT ["./event_store.sh"]
CMD ["--db=/var/opt/EventStore/ESData", "--http-prefixes=http://*:2113/", "--ext-ip=0.0.0.0"]
