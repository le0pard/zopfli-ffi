module Zopfli
  module C
    # struct
    class ZopfliConfig < FFI::Struct
      layout  :type, :int,
              :numiterations, :int
    end

    attach_function :zopfli_convert, [:string, :string, :pointer], :int

    attach_function :test_c, [:int], :int

  end
end
