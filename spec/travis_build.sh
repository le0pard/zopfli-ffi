#/usr/bin/env sh
git clone https://github.com/Hello71/zopfli.git
cd zopfli
make all && make prefix=$HOME/opt install
