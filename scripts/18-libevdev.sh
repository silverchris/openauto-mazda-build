source "$(dirname "$0")/settings.sh"

git clone https://gitlab.freedesktop.org/libevdev/libevdev.git
cd libevdev || exit
./autogen.sh
./configure --host=arm-mazda-linux-musleabi --with-sysroot="$SYSROOT" --prefix=/usr
make
make install
