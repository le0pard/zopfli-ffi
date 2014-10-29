require 'zopfli_ffi'
require 'zlib'
require 'benchmark'

in_dir = File.expand_path(File.dirname(__FILE__))
out_dir = File.expand_path(File.join(File.dirname(__FILE__), "../tmp/"))

Benchmark.bm(7) do |x|

  x.report("Gzip:") do
    Zlib::GzipWriter.open("#{out_dir}/1.jpg.gz") do |gz|
      gz.write IO.binread("#{in_dir}/1.jpg")
    end
  end

  x.report("Zopfli (5 iterations):") do
    Zopfli.compress("#{in_dir}/1.jpg", "#{out_dir}/1_15.jpg.zfl", :zlib, 5)
  end

  x.report("Zopfli (50 iterations):") do
    Zopfli.compress("#{in_dir}/1.jpg", "#{out_dir}/1_100.jpg.zfl", :zlib, 50)
  end

end