#/usr/bin/env sh
git clone https://github.com/Hello71/zopfli.git
cd zopfli
git submodule update --init
make -j2 && make prefix=$HOME/opt -j2 install
