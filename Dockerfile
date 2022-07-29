#FROM alpine:3.8
FROM alpine:latest
ARG CTNG_UID=1000
ARG CTNG_GID=1000
RUN addgroup -g $CTNG_GID ctng
RUN yes password | adduser -h /home/ctng -G ctng -u $CTNG_UID -s /bin/bash ctng
# Activate community and testing repositories
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories
RUN apk update
RUN apk add alpine-sdk wget xz git bash autoconf automake bison flex texinfo help2man gawk libtool ncurses-dev gettext-dev python3-dev rsync coreutils
RUN git clone --branch crosstool-ng-1.25.0 https://github.com/crosstool-ng/crosstool-ng.git
RUN cd crosstool-ng && ./bootstrap && ./configure --prefix=/opt/ctng/ && make && make install
ENV PATH="/opt/ctng/bin:${PATH}"
RUN mkdir /opt/x-tools && chown ctng /opt/x-tools && chmod 777 /opt/x-tools

USER ctng
RUN mkdir -p /home/ctng/build

WORKDIR /home/ctng/build
ADD .config .
COPY --chown=ctng source /home/ctng/src
RUN ls /home/ctng/src
RUN ct-ng source
RUN ct-ng build || ( cat build.log && exit 1 )
#USER root
#RUN apk add openssh
#RUN ( \
#    echo 'LogLevel DEBUG2'; \
#    echo 'PermitRootLogin yes'; \
#    echo 'PasswordAuthentication yes'; \
#    echo 'Subsystem sftp internal-sftp'; \
#  ) > /etc/ssh/sshd_config_test_clion \
#  && mkdir /run/sshd
#RUN cd /etc/ssh && ssh-keygen -A
#CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_test_clion"]


FROM alpine:latest
COPY --from=0 /opt/x-tools /opt/x-tools
RUN apk update && apk add alpine-sdk wget xz git bash autoconf automake bison flex texinfo help2man gawk libtool ncurses-dev gettext-dev rsync coreutils libtool pkgconfig meson ninja gperf cmake linux-headers expat expat-dev zip popt popt-dev python3 openssh gdb-multiarch
RUN mkdir /root/build
WORKDIR /root/build
COPY scripts ./scripts
COPY cross_file.txt cross_file_systemd.txt arm-mazda-linux-musleabi.toolchain ./
COPY patches ./patches
COPY sources ./sources
RUN mv sources/* .
RUN sh scripts/09-protobuf.sh
RUN sh scripts/10-openssl.sh
RUN sh scripts/11-protobuf.sh
RUN sh scripts/12-libusb.sh
RUN sh scripts/13-alsa.sh
RUN sh scripts/14-asio.sh
RUN sh scripts/15-sigc++.sh
#RUN sh scripts/16-boost.sh
RUN sh scripts/18-libevdev.sh
RUN sh scripts/19-dbus-cxx.sh
RUN sh scripts/20-dbus-cxx-tools.sh
RUN sh scripts/21-fdk-aac.sh
RUN ( \
    echo 'LogLevel DEBUG2'; \
    echo 'PermitRootLogin yes'; \
    echo 'PasswordAuthentication yes'; \
    echo 'Subsystem sftp internal-sftp'; \
  ) > /etc/ssh/sshd_config_test_clion \
  && mkdir /run/sshd

RUN yes password | adduser "user"
RUN cd /etc/ssh && ssh-keygen -A

CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_test_clion"]
#
##   docker build -t mazdabuild/cmake:0.5 -f Dockerfile .
##   docker run -d --cap-add sys_ptrace -p 127.0.0.1:2222:22 --name openauto-mazda-build_remote_env openauto-mazda-build:latest