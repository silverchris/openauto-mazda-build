if [ ! -f "libsigc++-3.2.0.tar.xz" ]; then
    wget -q https://github.com/libsigcplusplus/libsigcplusplus/releases/download/3.2.0/libsigc++-3.2.0.tar.xz
fi

rm -rv libsigc++-3.2.0
tar xf libsigc++-3.2.0.tar.xz
cd libsigc++-3.2.0 || exit
meson build .
cd build || exit
ninja
ninja install

rm dbus-cxx -rv
git clone https://github.com/silverchris/dbus-cxx.git
cd dbus-cxx || exit
mkdir build
cd build || exit
cmake .. -DENABLE_TOOLS=ON -DBUILD_TESTING=off
make
make install