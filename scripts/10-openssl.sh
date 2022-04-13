source "$(dirname "$0")/settings.sh"

if [ ! -f "openssl-1.1.1h.tar.gz" ]; then
    wget -q https://www.openssl.org/source/openssl-1.1.1h.tar.gz
fi

tar xvf openssl-1.1.1h.tar.gz
cd openssl-1.1.1h || exit
./Configure linux-armv4 -march=armv7-a --cross-compile-prefix=arm-mazda-linux-musleabi- --prefix="$SYSROOT"/usr
make
make install
