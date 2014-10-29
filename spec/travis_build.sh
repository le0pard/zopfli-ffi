#/usr/bin/env sh
git clone https://github.com/Hello71/zopfli.git
cd zopfli
make && sudo make install
sudo ln -fs /usr/local/lib/libzopfli.* /usr/lib/
