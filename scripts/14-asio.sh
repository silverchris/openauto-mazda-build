source "$(dirname "$0")/settings.sh"

if [ ! -f "asio-1.18.0.tar.bz2" ]; then
    wget -q http://sourceforge.net/projects/asio/files/asio/1.18.0%20%28Stable%29/asio-1.18.0.tar.bz2/download -O asio-1.18.0.tar.bz2
fi

tar xvf asio-1.18.0.tar.bz2
cd asio-1.18.0 || exit
./configure --host=arm-mazda-linux-musleabi --with-sysroot="$SYSROOT" --prefix=/usr/
make -j`nproc`
make install
