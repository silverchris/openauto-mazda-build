source "$(dirname "$0")/settings.sh"

git clone https://github.com/mstorsjo/fdk-aac.git
cd fdk-aac || exit
sed -i 's/SHARED/STATIC/g' CMakeLists.txt
mkdir build
cd build || exit
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../../arm-mazda-linux-musleabi.toolchain -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=off -DBUILD_TESTING=off
make -j`nproc`
make install
