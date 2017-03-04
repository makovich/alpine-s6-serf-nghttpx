FROM makovich/alpine-s6-serf:0.5

RUN addgroup -S httpd \
 && adduser -S -D -h /www -s /sbin/nologin -G httpd -g httpd httpd

COPY rootfs /

# Run at container init s6-fdholderd (it "down" by default)
RUN s6-rmrf /etc/s6/services/s6-fdholderd/down

# Write log to /var/log/s6-uncaught-logs instead of Docker's std{out,err}
ENV S6_LOGGING 1

# Serf node settings
ENV FRONTEND_NAME ${FRONTEND_NAME:-fe.serf}
ENV BACKEND_PORT 8080
ENV BACKEND_PATTERN /httpd/

VOLUME /var/log
