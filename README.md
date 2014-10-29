# Zopfli-ffi [![Build Status](https://travis-ci.org/le0pard/zopfli-ffi.svg?branch=master)](https://travis-ci.org/le0pard/zopfli-ffi)

Ruby wrapper for [Zopfli](https://code.google.com/p/zopfli/) library. Zopfli Compression Algorithm is a new zlib (gzip, deflate) compatible compressor. This compressor takes more time (~100x slower), but compresses around 5% better than zlib and better than any other zlib-compatible compressor.

### Requirements

First of all you should have install libraries: zopfli, zlib.

For Ubuntu, Debian:

    sudo apt-get install git build-essential zlib1g-dev

Next you should install zopfli:

    git clone https://github.com/Hello71/zopfli.git
    cd zopfli
    make && sudo make install


This gem is not support Windows and Mac OS systems (libzopfli isn't compiling on this systems).

## Installation

Add this line to your application's Gemfile:

    gem 'zopfli-ffi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zopfli-ffi

## Usage

Very simple usage example:

```ruby
require 'zlib'
require 'zopfli_ffi'

uncompressed_file = 'spec/fixtures/test.txt'
compressed_file = 'spec/fixtures/test.txt.gz'

Zopfli.compress(uncompressed_file, compressed_file)

uncompressed_data = File.read(uncompressed_file)
uncompressed_zopfli_data = Zlib::Inflate.inflate File.read(compressed_file)
uncompressed_zopfli_data == uncompressed_data # true
```

You can define format of compression (`:zlib` is default):

```ruby
Zopfli.compress(uncompressed_file, compressed_file, :zlib) # default format
Zopfli.compress(uncompressed_file, compressed_file, :deflate)
Zopfli.compress(uncompressed_file, compressed_file, :gzip)
```

Also you can define number of iterations for compression (greater number - better compression, but slower compression time; default = 15):

```ruby
Zopfli.compress(uncompressed_file, compressed_file, :zlib, 15) # default format
Zopfli.compress(uncompressed_file, compressed_file, :deflate, 5)
Zopfli.compress(uncompressed_file, compressed_file, :zlib, 25)
```

## Contributing

1. Fork it ( http://github.com/le0pard/zopfli-ffi/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
