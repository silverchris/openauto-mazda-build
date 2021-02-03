source "$(dirname "$0")/settings.sh"

#wget -q ftp://sourceware.org/pub/gdb/releases/gdb-10.1.tar.xz
#tar xf gdb-10.1.tar.xz
cd gdb-10.1 || exit
./configure --host=arm-mazda-linux-musleabi --with-sysroot="$SYSROOT" --prefix=/usr/ --with-static-standard-libraries --with-build-sysroot="$SYSROOT" --disable-source-highlight
make
make install
