FROM makovich/alpine-s6:0.5

ENV SERF_VERSION 0.8.0

RUN addgroup -S serf \
 && adduser -S -D -H -s /sbin/nologin -G serf -g serf serf

RUN apk add --no-cache --virtual .build-deps \
        curl \
        gnupg \

 && export GNUPGHOME="$(mktemp -d)" \

 && curl -sSL https://keybase.io/hashicorp/key.asc | gpg --import \
 && curl -sSOL https://releases.hashicorp.com/serf/${SERF_VERSION}/serf_${SERF_VERSION}_SHA256SUMS \
 && curl -sSOL https://releases.hashicorp.com/serf/${SERF_VERSION}/serf_${SERF_VERSION}_SHA256SUMS.sig \
 && curl -sSOL https://releases.hashicorp.com/serf/${SERF_VERSION}/serf_${SERF_VERSION}_linux_amd64.zip \

 && gpg --batch --verify serf_${SERF_VERSION}_SHA256SUMS.sig serf_${SERF_VERSION}_SHA256SUMS \
 && grep serf_${SERF_VERSION}_linux_amd64.zip serf_${SERF_VERSION}_SHA256SUMS | sha256sum -c \

 && unzip -d /bin serf_${SERF_VERSION}_linux_amd64.zip \

 && rm -r "$GNUPGHOME" serf_${SERF_VERSION}_* \
 && apk del .build-deps       

COPY rootfs /
