source "$(dirname "$0")/settings.sh"

wget -q https://github.com/libusb/libusb/archive/v1.0.23.tar.gz
tar xf v1.0.23.tar.gz
cd libusb-1.0.23 || exit
./autogen.sh
./configure --host=arm-mazda-linux-musleabi --with-sysroot="$SYSROOT" --prefix=/usr --disable-udev #--enable-debug-log
make
make install
