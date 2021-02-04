source "$(dirname "$0")/settings.sh"

#git clone https://github.com/Kistler-Group/sdbus-cpp.git
git clone https://github.com/ChristianS99/sdbus-cpp.git
cd sdbus-cpp || exit
mkdir build
cd build || exit
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../../arm-mazda-linux-musleabi.toolchain -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=off
make
make install