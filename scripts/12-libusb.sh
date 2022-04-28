source "$(dirname "$0")/settings.sh"

if [ ! -f "libusb-1.0.23.tar.gz" ]; then
    wget -q https://github.com/libusb/libusb/archive/v1.0.23.tar.gz -O libusb-1.0.23.tar.gz
fi

tar xf libusb-1.0.23.tar.gz
cd libusb-1.0.23 || exit
./autogen.sh
./configure --host=arm-mazda-linux-musleabi --with-sysroot="$SYSROOT" --prefix=/usr --disable-udev #--enable-debug-log
make -j`nproc`
make install
