source "$(dirname "$0")/settings.sh"

wget -q https://mirrors.edge.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.46.tar.xz
tar xf libcap-2.46.tar.xz
cd libcap-2.46 || exit
sed -i 's^LIBDIR=$(lib_prefix)/$(lib)^LIBDIR=/usr/lib/^g' -i Make.Rules
make -C libcap _makenames
make CROSS_COMPILE=/home/silverchris/x-tools/arm-mazda-linux-musleabi/bin/arm-mazda-linux-musleabi-
make install
