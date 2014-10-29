require 'ffi'
require 'ffi-compiler/loader'

module Zopfli
  module C
    extend FFI::Library
    ffi_lib FFI::Compiler::Loader.find('zopfli_ffi')
  end
end

require "zopfli/c"
require "zopfli/options"
require "zopfli/zopfii"
require "zopfli/version"