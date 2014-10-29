require "zopfli/c"

module Zopfli
  class Options

    attr_reader :type, :iterations

    def initialize(type, iterations)
      @type, @iterations = type, iterations
    end

    def compress_pointer
      options_pointer = FFI::MemoryPointer.new :char, C::ZopfliConfig.size, false
      options_struct = C::ZopfliConfig.new options_pointer

      options_struct[:type] = case type
        when :deflate then 1
        when :gzip then 2
        else 0
      end

      options_struct[:numiterations] = iterations.to_i if iterations.to_i > 0

      options_pointer
    end

  end
end