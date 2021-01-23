source "$(dirname "$0")/settings.sh"

git clone https://github.com/silverchris/aasdk.git

cd aasdk || exit
git checkout development
git pull
cmake -DCMAKE_TOOLCHAIN_FILE=../arm-mazda-linux-musleabi.toolchain -DCMAKE_INSTALL_PREFIX=/usr .
make -j10
make install
