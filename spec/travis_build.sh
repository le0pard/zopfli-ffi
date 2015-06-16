#/usr/bin/env sh
PREFIX := $HOME/opt
BINDIR := $(PREFIX)/bin
LIBDIR := $(PREFIX)/lib
INCLUDEDIR := $(PREFIX)/include

git clone https://github.com/google/zopfli.git
cd zopfli
make && make libzopfli && make zopflipng && make libzopflipng

mkdir -p $(BINDIR)
install -m755 zopfli zopflipng $(BINDIR)
mkdir -p $(LIBDIR)
install -m755 libzopfli.so.1.0.1 $(LIBDIR)
cp -d libzopfli.so libzopfli.so.1.0.1 libzopfli.so.1 \
      libzopflipng.so libzopflipng.so.1.0.0 libzopflipng.so.1 \
      $(LIBDIR)
mkdir -p $(INCLUDEDIR)/zopfli
install -m644 src/zopfli/deflate.h src/zopfli/zlib_container.h \
              src/zopfli/zopfli.h src/zopfli/katajainen.h \
	      src/zopfli/tree.h src/zopfli/gzip_container.h \
	      src/zopfli/cache.h src/zopfli/squeeze.h \
	      src/zopfli/lz77.h src/zopfli/util.h \
	      src/zopfli/blocksplitter.h src/zopfli/hash.h \
	      $(INCLUDEDIR)/zopfli
