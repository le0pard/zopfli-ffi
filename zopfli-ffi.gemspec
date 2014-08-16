# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zopfli/version'

Gem::Specification.new do |spec|
  spec.name          = "zopfli-ffi"
  spec.version       = Zopfli::VERSION
  spec.authors       = ["Alexey Vasiliev"]
  spec.email         = ["leopard.not.a@gmail.com"]
  spec.summary       = %q{Ruby wrapper for Zopfli library}
  spec.description   = %q{Ruby wrapper for Zopfli library}
  spec.homepage      = "http://leopard.in.ua/zopfli-ffi"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.extensions    << 'ext/zopfli_ffi/Rakefile'

  spec.add_runtime_dependency "ffi", ">= 1.9.0"
  spec.add_runtime_dependency "ffi-compiler", ">= 0.1.2"

  spec.add_development_dependency "bundler", ">= 1.2"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3"
end
