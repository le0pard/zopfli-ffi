require 'spec_helper'
require 'zlib'
require 'benchmark'

describe Zopfli do
  before :all do
    @out_dir = File.expand_path(File.join(File.dirname(__FILE__), "../tmp/"))
    Dir.mkdir(@out_dir) unless File.exists?(@out_dir)
  end
  after :all do
    @out_dir = File.expand_path(File.join(File.dirname(__FILE__), "../tmp/"))
    Dir["#{@out_dir}/*{.txt,.zfl}"].each do |file|
      File.delete(file) rescue nil
    end
  end

  it "calculate plus 100 by test_c (verify C)" do
    expect(Zopfli::C.test_c(100)).to eq(200)
    expect(Zopfli::C.test_c(150)).to eq(250)
  end

  describe 'check files compression' do
    ['test0.txt', 'test1.txt', 'test2.svg'].each do |fixture|

      it "#{fixture} in result must be the same" do
        uncompressed_file = "spec/fixtures/#{fixture}"
        compressed_file = "#{@out_dir}/#{fixture}.zfl"
        # made compress
        Zopfli.compress(uncompressed_file, compressed_file)

        uncompressed_data, compressed_data = File.read(uncompressed_file), File.read(compressed_file)
        # check
        expect(Zlib::Inflate.inflate(compressed_data)).to eq(uncompressed_data)
      end

    end
  end

  describe 'check formats' do
    [:deflate, :gzip, :zlib].each do |format|

      it "#{format} in result must be the same" do
        uncompressed_file = "spec/fixtures/test0.txt"
        compressed_file = "#{@out_dir}/test0.txt.zfl"
        # made compress
        Zopfli.compress(uncompressed_file, compressed_file, format)

        uncompressed_data, compressed_data = File.read(uncompressed_file), File.read(compressed_file)
        # check
        case format
          when :deflate
            # no matchers
          when :gzip
            gz = Zlib::GzipReader.new(StringIO.new(compressed_data))
            expect(gz.read).to eq(uncompressed_data)
          else
            expect(Zlib::Inflate.inflate(compressed_data)).to eq(uncompressed_data)
        end
      end

    end
  end

  describe 'check iterations' do
    it "with more iterations must be slower" do
      uncompressed_file = "spec/fixtures/test0.txt"
      compressed_file = "#{@out_dir}/test0.txt.zfl"
      # made compress
      slow_time = Benchmark.realtime do
        Zopfli.compress(uncompressed_file, compressed_file, :zlib, 50)
      end
      fast_time = Benchmark.realtime do
        Zopfli.compress(uncompressed_file, compressed_file, :zlib, 2)
      end

      expect(fast_time).to be < slow_time
    end
  end


end