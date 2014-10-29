require "zopfli/options"
require "zopfli/c"

module Zopfli
  class << self

    # encode
    def compress(input_file, output_file, type = :zlib, iterations = 15)
      C.zopfli_convert(input_file, output_file, get_options_object(type, iterations))
    end

    private

    def get_options_object(type, iterations)
      Options.new(type, iterations).compress_pointer
    end

  end
end