source "$(dirname "$0")/settings.sh"

git clone https://github.com/cryptodev-linux/cryptodev-linux.git
install -m 644 -D cryptodev-linux/crypto/cryptodev.h "$SYSROOT"/usr/include/crypto/cryptodev.h

if [ ! -f "openssl-3.0.2.tar.gz" ]; then
    wget -q https://www.openssl.org/source/openssl-3.0.2.tar.gz
fi

tar xvf openssl-3.0.2.tar.gz
cd openssl-3.0.2 || exit
./Configure linux-armv4 no-ssl3 no-ssl2 no-idea no-dtls no-psk no-srp no-weak-ssl-ciphers no-shared enable-devcryptoeng -static -march=armv7-a --cross-compile-prefix=arm-mazda-linux-musleabi- -mtune=cortex-a9 -mfpu=neon -fexpensive-optimizations -frename-registers -fomit-frame-pointer --prefix="$SYSROOT"/usr
#./Configure linux-armv4 no-ssl3 no-ssl2 no-idea no-dtls no-psk no-srp no-weak-ssl-ciphers no-shared -static -march=armv7-a --cross-compile-prefix=arm-mazda-linux-musleabi- -mtune=cortex-a9 -mfpu=neon -fexpensive-optimizations -frename-registers -fomit-frame-pointer --prefix="$SYSROOT"/usr

make -j`nproc`
make install_sw
