source "$(dirname "$0")/settings.sh"
git clone https://github.com/systemd/systemd
cd systemd || exit
git checkout v247 # or any other recent stable version
for filename in ../patches/systemd/*; do
  patch -p1 <"$filename"
done

mkdir build
cd build || exit
meson --buildtype=release --prefix=/usr/ --libdir=lib --cross-file=../../cross_file_systemd.txt ..
meson configure -Dstatic-libsystemd=true -Dgshadow=false -Didn=false -Dlocaled=false -Dnss-myhostname=false -Dnss-systemd=false -Dnss-mymachines=false -Dnss-resolve=false -Dsysusers=false -Duserdb=false -Dutmp=false -Dtmpfiles=false -Dnetworkd=false -Dtests=false -Dtests=false -Dslow-tests=false -Dinstall-tests=false -Dresolve=false -Dldconfig=false -Dnss-resolve=false -Dnss-mymachines=false .
ninja version.h            # building version.h target is only necessary in systemd version >= 241
ninja libsystemd.so.0.30.0 # or another version number depending which systemd version you have
ninja libsystemd.a
cp libsystemd.a "$SYSROOT/usr/lib/"
cp libsystemd.so.0.30.0 "$SYSROOT/usr/lib"
cp src/libsystemd/libsystemd.pc "$SYSROOT/usr/lib/pkgconfig"
cp -av ../src/systemd "$SYSROOT/usr/include/"
