FROM alpine:3.5

ENV S6_OVERLAY_VERSION 1.19.1.1

RUN apk add --no-cache --virtual .build-deps \
        curl \
        gnupg \

 && export GNUPGHOME="$(mktemp -d)" \

 && curl -sL https://keybase.io/justcontainers/key.asc | gpg --import \
 && curl -sL https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz -o s6-overlay.tar.gz \
 && curl -sL https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz.sig -o s6-overlay.tar.gz.sig \

 && gpg --verify s6-overlay.tar.gz.sig s6-overlay.tar.gz \
 && rm -r "$GNUPGHOME" s6-overlay.tar.gz.sig \

 && tar -xvzC / -f s6-overlay.tar.gz \

 && rm s6-overlay.tar.gz \
 && apk del .build-deps       

# Base s6-overlay layout
COPY rootfs /

ENTRYPOINT [ "/init" ]
