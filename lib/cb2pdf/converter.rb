#encoding: utf-8

require 'prawn'
require 'prawn/measurement_extensions'
require 'fastimage'
require 'tmpdir'
require 'fileutils'
require 'timeout'

require_relative 'formats'
require_relative 'errors'
require_relative 'os'

module CB2PDF
  class Converter
    @seven_zip_path = OS.windows? ? "#{File.dirname(File.expand_path(__FILE__))}/../../bin/7z-v1700-x86.exe" : "7z"
    @console_output = false
    @seven_zip_output = false

    class << self
      attr_accessor :seven_zip_path, :console_output, :seven_zip_output
    end

    # converts a comic book archive to pdf and returns the generated file's path. <br />
    # only .jpg, .jpeg and .png image formats are supported, all other formats are ignored. <br />
    # arguments: <br />
    # +file::+ archive to be converted
    # +outdir::+ output directory of converted file
    def self.convert(file, outdir)
      puts "processing file: #{file.length > 100 ? "#{file[0..45]}.....#{file[-50..-1]}" : file}" if console_output

      from = File.extname file
      raise UnknownFormatError, "Unknown source format: #{from}" unless Formats::cb_formats.include?(from)

      print "starting 7zip...#{seven_zip_output ? lines : ""}" if console_output
      dir = Dir.mktmpdir
      cmd = [seven_zip_path, "e", "#{file}", "-o#{dir}"]
      cmd << {[:out, :err] => File::NULL} unless seven_zip_output

      success = system(*cmd)
      output_file = File.expand_path("#{outdir}/#{File.basename(file, from)}#{Formats::PDF}")

      if success
        print "#{seven_zip_output ? lines : ""}assembling pdf..." if console_output

        Prawn::Document.generate(output_file,:margin => [0,0,0,0], :skip_page_creation => true) do
          Dir.foreach("#{dir}") do |item|
            next if item == '.' or item == '..' or not Formats::image_formats.include?(File.extname(item))
            image_path = "#{dir}/#{item}"

            image_size = FastImage.size(image_path)
            page_size = [image_size[0] + 1.in, image_size[1] + 1.5.in]

            start_new_page(:size => page_size, :layout => :portrait)
            image(image_path, position: :left, vposition: :top, fit: page_size)
          end
        end
        puts "done!" if console_output
      else
        raise ExtractionError, "failed to extract archive!"
      end
      # make sure tempdir is deleted, while loop because 7zip is too fast sometimes :)
      # but cancel after 3 seconds
      begin
        timeout = 3
        Timeout::timeout(timeout) do
          while File.directory? dir
            FileUtils.rm_rf dir
          end
        end
      rescue TimeoutError => e
        raise e, "temporary extraction directory could not be deleted after #{timeout} seconds: #{dir}"
      end

      # return generated file path
      output_file
    end

    private
    def self.lines
      "\n==============================================\n"
    end
  end
end
