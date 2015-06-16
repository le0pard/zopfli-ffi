#/usr/bin/env sh
git clone https://github.com/google/zopfli.git
cd zopfli
make && make libzopfli && make zopflipng && make libzopflipng

mkdir -p $HOME/opt/bin
install -m755 zopfli zopflipng $HOME/opt/bin
mkdir -p $HOME/opt/lib
install -m755 libzopfli.so.1.0.1 $HOME/opt/lib
cp -d libzopfli.so libzopfli.so.1.0.1 libzopfli.so.1 \
      libzopflipng.so libzopflipng.so.1.0.0 libzopflipng.so.1 \
      $HOME/opt/lib
mkdir -p $HOME/opt/include/zopfli
install -m644 src/zopfli/deflate.h src/zopfli/zlib_container.h \
              src/zopfli/zopfli.h src/zopfli/katajainen.h \
	      src/zopfli/tree.h src/zopfli/gzip_container.h \
	      src/zopfli/cache.h src/zopfli/squeeze.h \
	      src/zopfli/lz77.h src/zopfli/util.h \
	      src/zopfli/blocksplitter.h src/zopfli/hash.h \
	      $HOME/opt/include/zopfli
