# encoding: utf-8

require 'minitest/autorun'
require 'tmpdir'
require 'fileutils'
require_relative '../../lib/cb2pdf'

describe 'Converter' do

  let(:cbr) { "#{File.dirname(__FILE__)}/../resources/test.cbr" }
  let(:cbz) { "#{File.dirname(__FILE__)}/../resources/test.cbz" }
  let(:cb7) { "#{File.dirname(__FILE__)}/../resources/test.cb7" }

  def check_and_clean(source_file, target_file)
    File.exists?(target_file).must_equal true
    File.size?(target_file).must_be :>=, File.size?(source_file)
    File.delete target_file
  end

  it '::convert from cbz to pdf' do
    Dir.mktmpdir do |dir|
      CB2PDF::Converter.convert cbz,dir
      check_and_clean cbz, "#{dir}/test.pdf"
    end
  end

  it '::convert from cbr to pdf' do
    Dir.mktmpdir do |dir|
      CB2PDF::Converter.convert cbr, dir
      check_and_clean cbr, "#{dir}/test.pdf"
    end
  end

  it '::convert from cb7 to pdf' do
    Dir.mktmpdir do |dir|
      CB2PDF::Converter.convert cb7, dir
      check_and_clean cb7, "#{dir}/test.pdf"
    end
  end

end
