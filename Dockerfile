FROM alpine:latest
MAINTAINER Andreas Wölfl andreas.woelfl84@gmail.com

# environment variables
ENV PLATFORM_ARCH="x86_64"
ENV ENCFS6_CONFIG="/config/encfs.xml"


# install packages
RUN apk add --no-cache curl tar wget encfs xz

ARG S6_OVERLAY_VERSION=3.1.2.1
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

# remove packages
RUN apk del curl tar wget xz

# create dirs
RUN mkdir -p /src /dest /config

# copy services
COPY root/ / 

# create volumes
VOLUME /src /dest /config

ENTRYPOINT ["/init"]
