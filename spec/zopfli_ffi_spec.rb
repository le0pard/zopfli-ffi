require 'spec_helper'

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
end