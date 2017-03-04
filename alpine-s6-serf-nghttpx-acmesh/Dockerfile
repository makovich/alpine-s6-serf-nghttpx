FROM makovich/alpine-s6-serf:0.5

#
# 1. nghttpx
#

ENV NGHTTP2_VERSION 1.18.1

RUN addgroup -S nghttpx \
 && adduser -S -D -H -s /sbin/nologin -G nghttpx -g nghttpx nghttpx

RUN apk add --no-cache \
        libev \
        libressl \
        c-ares \
        zlib \
        libstdc++ \
        libgcc

RUN apk add --no-cache --virtual .build-deps \
        alpine-sdk \
        libtool \
        autoconf \
        automake \
        jemalloc-dev \
        libev-dev \
        libressl-dev \
        c-ares-dev \
        zlib-dev \
        bison \
        ruby \

 && git clone --depth 1 --single-branch --branch v${NGHTTP2_VERSION} https://github.com/nghttp2/nghttp2.git /nghttp2 \
 && cd /nghttp2 \
 && git submodule update --init \

 && autoreconf -i \
 && automake \
 && autoconf \
 && ./configure \
        --prefix=/usr \
        --disable-static \
        --with-mruby \
        --with-neverbleed \
        --without-libxml2 \
        --without-spdylay \
        --without-jemalloc \
        --disable-python-bindings \
        --enable-app \

 && make \
 && make install \

 && apk del .build-deps \
 && rm -rf /nghttp2


#
# 2. acme.sh
#

ENV ACME_SH_VERSION 2.6.5
ENV ACME_SH_HTTP_PORT 18881
ENV ACME_SH_HOME_DIR /var/acme.sh
ENV ACME_SH_CERT_DIR /var/acme.sh/certs

RUN addgroup -S acmesh \
 && adduser -S -D -h ${ACME_SH_HOME_DIR} -s /sbin/nologin -G acmesh -g acmesh acmesh

RUN apk add --no-cache curl \
 && curl -sL https://raw.githubusercontent.com/Neilpang/acme.sh/${ACME_SH_VERSION}/acme.sh -o /usr/bin/acme.sh

#
# 3. s6-overlay
#

COPY rootfs /

# Run at container init s6-fdholderd (it "down" by default)
RUN s6-rmrf /etc/s6/services/s6-fdholderd/down

# Write log to /var/log/s6-uncaught-logs instead of Docker's std{out,err}
ENV S6_LOGGING 1

VOLUME ${ACME_SH_HOME_DIR}
VOLUME /var/log

# HTTP, HTTPS and healthmon endpoints
EXPOSE 80 443 3000
