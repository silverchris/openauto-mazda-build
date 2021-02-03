source "$(dirname "$0")/settings.sh"

wget -q https://github.com/libsigcplusplus/libsigcplusplus/releases/download/2.10.4/libsigc++-2.10.4.tar.xz
tar xf libsigc++-2.10.4.tar.xz
cd libsigc++-2.10.4 || exit
meson --prefix=/usr/ --libdir=lib --cross-file=../cross_file.txt --default-library=both build .
cd build || exit
ninja
ninja install
