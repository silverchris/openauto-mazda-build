wget -q https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/protobuf-cpp-3.14.0.tar.gz
tar xvf protobuf-cpp-3.14.0.tar.gz
cd protobuf-3.14.0 || exit
./configure
make -j12
make install
cd ..
rm -rf protobuf-3.14.0
