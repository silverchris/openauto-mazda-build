SYSROOT="/opt/x-tools/arm-mazda-linux-musleabi/arm-mazda-linux-musleabi/sysroot"
export PKG_CONFIG_DIR=""
export PKG_CONFIG_LIBDIR="$SYSROOT/usr/lib/pkgconfig"
export PKG_CONFIG_SYSROOT_DIR=$SYSROOT
export PATH="$PATH:/opt/x-tools/arm-mazda-linux-musleabi/bin"
export DESTDIR=$SYSROOT

echo $SYSROOT
echo $PKG_CONFIG_DIR
echo $PKG_CONFIG_LIBDIR
echo $PKG_CONFIG_SYSROOT_DIR
echo "$PATH"

find $SYSROOT/usr/lib -name '*.la' -delete
