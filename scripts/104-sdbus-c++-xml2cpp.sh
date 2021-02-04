#git clone https://github.com/Kistler-Group/sdbus-cpp.git
git clone https://github.com/ChristianS99/sdbus-cpp.git
cd sdbus-cpp || exit
mkdir hostbuild
cd hostbuild || exit
cmake ../tools/ -DCMAKE_BUILD_TYPE=Release
make
make install