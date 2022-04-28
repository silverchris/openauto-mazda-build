
if [ ! -f "protobuf-cpp-3.14.0.tar.gz" ]; then
    wget -q https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/protobuf-cpp-3.14.0.tar.gz
fi

tar xvf protobuf-cpp-3.14.0.tar.gz
cd protobuf-3.14.0 || exit
./configure
make -j`nproc`
make install
cd ..
rm -rf protobuf-3.14.0
