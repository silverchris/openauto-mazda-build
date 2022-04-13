source "$(dirname "$0")/settings.sh"

if [ ! -f "protobuf-cpp-3.14.0.tar.gz" ]; then
    wget -q https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/protobuf-cpp-3.14.0.tar.gz
fi

tar xvf protobuf-cpp-3.14.0.tar.gz
cd protobuf-3.14.0 || exit
./configure --disable-shared --host=arm-mazda-linux-musleabi --with-sysroot="$SYSROOT" --with-protoc=protoc --prefix=/usr/ LDFLAGS="-static-libgcc -static-libstdc++" CXXFLAGS="-static-libgcc -static-libstdc++"
make -j32 LDFLAGS="-static-libgcc -static-libstdc++" CXXFLAGS="-static-libgcc -static-libstdc++"
make install
