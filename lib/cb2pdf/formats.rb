# encoding: utf-8

module CB2PDF
  module Formats
    CBR = '.cbr'
    CBZ = '.cbz'
    CB7 = '.cb7'
    PDF = '.pdf'

    JPG = '.jpg'
    JPEG = '.jpeg'
    PNG = '.png'

    def self.cb_formats
      [CBR, CBZ, CB7]
    end

    def self.image_formats
      [JPG, JPEG, PNG]
    end
  end
end

