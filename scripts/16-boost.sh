source "$(dirname "$0")/settings.sh"

if [ ! -f "boost_1_74_0.tar.gz" ]; then
    wget -q https://boostorg.jfrog.io/native/main/release/1.74.0/source/boost_1_74_0.tar.gz
fi

tar xf boost_1_74_0.tar.gz
cd boost_1_74_0 || exit
./bootstrap.sh
sed -i '/using gcc ;/c \using gcc : arm : arm-mazda-linux-musleabi-g++ ;' project-config.jam
./b2 install target-os=linux architecture=arm address-model=32 binary-format=elf threading=multi toolset=gcc-arm link=static --prefix="$SYSROOT"/usr/
