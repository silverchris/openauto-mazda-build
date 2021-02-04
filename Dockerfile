FROM alpine:3.8
ARG CTNG_UID=1000
ARG CTNG_GID=1000
RUN addgroup -g $CTNG_GID ctng
RUN adduser -D -h /home/ctng -G ctng -u $CTNG_UID -s /bin/bash ctng
# Activate community and testing repositories
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories
RUN apk update
RUN apk add alpine-sdk wget xz git bash autoconf automake bison flex texinfo help2man gawk libtool ncurses-dev gettext-dev python-dev rsync coreutils
RUN git clone https://github.com/crosstool-ng/crosstool-ng.git
RUN cd crosstool-ng && ./bootstrap && ./configure --prefix=/opt/ctng/ && make && make install
ENV PATH="/opt/ctng/bin:${PATH}"
RUN mkdir /opt/x-tools && chown ctng /opt/x-tools && chmod 777 /opt/x-tools

USER ctng
RUN mkdir -p /home/ctng/build

WORKDIR /home/ctng/build
ADD .config .
RUN ct-ng source
RUN ct-ng build || ( cat build.log && exit 1 )

FROM alpine:latest
COPY --from=0 /opt/x-tools /opt/x-tools
RUN apk update && apk add alpine-sdk wget xz git bash autoconf automake bison flex texinfo help2man gawk libtool ncurses-dev gettext-dev rsync coreutils libtool pkgconfig meson ninja gperf cmake linux-headers expat expat-dev
RUN mkdir /root/build
WORKDIR /root/build
COPY scripts ./scripts
COPY cross_file.txt cross_file_systemd.txt arm-mazda-linux-musleabi.toolchain ./
COPY patches ./patches
RUN sh scripts/09-protobuf.sh
RUN sh scripts/10-openssl.sh
RUN sh scripts/11-protobuf.sh
RUN sh scripts/12-libusb.sh
RUN sh scripts/13-alsa.sh
RUN sh scripts/14-asio.sh
RUN sh scripts/15-sigc++.sh
RUN sh scripts/16-boost.sh
RUN sh scripts/18-libevdev.sh
RUN sh scripts/100_libcap.sh
RUN sh scripts/101_util-linux.sh
RUN sh scripts/102-systemd.sh
RUN sh scripts/103-sdbus-cpp.sh
RUN sh scripts/104-sdbus-c++-xml2cpp.sh


