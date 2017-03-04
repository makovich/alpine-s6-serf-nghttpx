FROM makovich/alpine-s6-serf:0.5

ENV NGINX_VERSION 1.10.3

RUN apk add --no-cache --virtual .build-deps \
        git \
        linux-headers \
        gcc \
        libc-dev \
        make \

 && git clone --depth 1 --single-branch --branch release-${NGINX_VERSION} https://github.com/nginx/nginx.git /nginx \
 && cd /nginx \

 && ./auto/configure \
        --prefix=/etc/nginx \
        --sbin-path=/usr/sbin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/tmp/error.log \
        --http-log-path=/tmp/access.log \
        --pid-path=/tmp/nginx.pid \
        --lock-path=/tmp/nginx.lock \
        --http-client-body-temp-path=/var/cache/nginx/client_temp \
        --without-pcre \
        --without-http_uwsgi_module \
        --without-http_userid_module \
        --without-http_ssi_module \
        --without-http_split_clients_module \
        --without-http_scgi_module \
        --without-http_rewrite_module \
        --without-http_referer_module \
        --without-http_proxy_module \
        --without-http_memcached_module \
        --without-http_map_module \
        --without-http_limit_req_module \
        --without-http_limit_conn_module \
        --without-http_gzip_module \
        --without-http_geo_module \
        --without-http_fastcgi_module \
        --without-http_empty_gif_module \
        --without-http_charset_module \
        --without-http_browser_module \
        --without-http_autoindex_module \
        --without-http_auth_basic_module \
        --without-http_access_module \

 && make \
 && cp objs/nginx /usr/sbin/nginx \
 && mkdir -p /etc/nginx \
 && cp conf/mime.types /etc/nginx/mime.types \

 && apk del .build-deps \
 && rm -rf /nginx

RUN addgroup -S nginx \
 && adduser -S -D -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx

COPY rootfs /

# Run at container init s6-fdholderd (it "down" by default)
RUN s6-rmrf /etc/s6/services/s6-fdholderd/down

# Write log to /var/log/s6-uncaught-logs instead of Docker's std{out,err}
ENV S6_LOGGING 1

# Serf node settings
ENV FRONTEND_NAME ${FRONTEND_NAME:-fe.serf}
ENV BACKEND_PORT 8000
ENV BACKEND_PATTERN 28064212.date/

VOLUME /var/log
