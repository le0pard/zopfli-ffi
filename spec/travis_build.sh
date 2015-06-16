#/usr/bin/env sh
git clone https://github.com/Hello71/zopfli.git
cd zopfli
make -j2 && make -j2 test && make --prefix=$HOME/opt -j2 install
