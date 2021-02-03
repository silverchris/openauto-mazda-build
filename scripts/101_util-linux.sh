source "$(dirname "$0")/settings.sh"

wget -q https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.36/util-linux-2.36.tar.xz
tar xf util-linux-2.36.tar.xz
cd util-linux-2.36 || exit
./autogen.sh && ./configure --host=arm-mazda-linux-musleabi --with-sysroot="$SYSROOT" --prefix=/usr/ --disable-use-tty-group --disable-makeinstall-chown --disable-makeinstall-setuid
make
make install
