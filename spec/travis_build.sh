#/usr/bin/env sh
git clone https://github.com/google/zopfli.git
cd zopfli
make && make libzopfli && make libzopflipng && make prefix=$HOME/opt install
