# Use osixia/light-baseimage
# sources: https://github.com/osixia/docker-light-baseimage
FROM osixia/alpine-light-baseimage:0.1.4

# Keepalived version
ARG KEEPALIVED_VERSION=1.3.6

# Download, build and install Keepalived
RUN cp /etc/apk/repositories /etc/apk/repositories.bak \
    && echo "http://mirrors.aliyun.com/alpine/v3.4/main/" > /etc/apk/repositories \
    && apk --no-cache add \
       curl \
       gcc \
       ipset \
       ipset-dev \
       iptables \
       iptables-dev \
       libnfnetlink \
       libnfnetlink-dev \
       libnl3 \
       libnl3-dev \
       make \
       musl-dev \
       openssl \
       openssl-dev \
    && curl -o keepalived.tar.gz -SL http://keepalived.org/software/keepalived-${KEEPALIVED_VERSION}.tar.gz \
    && mkdir -p /container/keepalived-sources \
    && tar -xzf keepalived.tar.gz --strip 1 -C /container/keepalived-sources \
    && cd container/keepalived-sources \
    && ./configure --disable-dynamic-linking \
    && make && make install \
    && cd - && mkdir -p /etc/keepalived \
    && rm -f keepalived.tar.gz \
    && rm -rf /container/keepalived-sources \
    && apk --no-cache del \
        curl \
        gcc \
        ipset-dev \
        iptables-dev \
        libnfnetlink-dev \
        libnl3-dev \
        make \
        musl-dev \
        openssl-dev


# Add service directory to /container/service
ADD service /container/service

# Use baseimage install-service script
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/install-service
RUN /container/tool/install-service

# Add default env variables
ADD environment /container/environment/99-default
