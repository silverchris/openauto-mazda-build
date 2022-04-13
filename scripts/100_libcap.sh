source "$(dirname "$0")/settings.sh"

if [ ! -f "libcap-2.46.tar.xz" ]; then
    wget -q https://mirrors.edge.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.46.tar.xz
fi

tar xf libcap-2.46.tar.xz
cd libcap-2.46 || exit
sed -i 's^LIBDIR=$(lib_prefix)/$(lib)^LIBDIR=/usr/lib/^g' -i Make.Rules
make -C libcap _makenames
make CROSS_COMPILE=/opt/x-tools/arm-mazda-linux-musleabi/bin/arm-mazda-linux-musleabi-
make install
