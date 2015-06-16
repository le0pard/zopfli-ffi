#/usr/bin/env sh
git clone https://github.com/google/zopfli.git
cd zopfli
make && make libzopfli && make zopflipng && make libzopflipng

prefix = $HOME/opt
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
libdir = $(exec_prefix)/lib
includedir = $(prefix)/include

mkdir -p $(DESTDIR)$(bindir)
install -m755 zopfli zopflipng $(DESTDIR)$(bindir)
mkdir -p $(DESTDIR)$(libdir)
install -m755 libzopfli.so.1.0.1 $(DESTDIR)$(libdir)
cp -d libzopfli.so libzopfli.so.1.0.1 libzopfli.so.1 \
      libzopflipng.so libzopflipng.so.1.0.0 libzopflipng.so.1 \
      $(DESTDIR)$(libdir)
mkdir -p $(DESTDIR)$(includedir)/zopfli
install -m644 src/zopfli/deflate.h src/zopfli/zlib_container.h \
              src/zopfli/zopfli.h src/zopfli/katajainen.h \
	      src/zopfli/tree.h src/zopfli/gzip_container.h \
	      src/zopfli/cache.h src/zopfli/squeeze.h \
	      src/zopfli/lz77.h src/zopfli/util.h \
	      src/zopfli/blocksplitter.h src/zopfli/hash.h \
	      $(DESTDIR)$(includedir)/zopfli
