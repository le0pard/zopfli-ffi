#/usr/bin/env sh
git clone https://github.com/Hello71/zopfli.git
cd zopfli
make && make prefix=$HOME/opt install
