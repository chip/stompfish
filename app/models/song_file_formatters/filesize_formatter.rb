module SongFileFormatters
  class FilesizeFormatter
    include ActionView::Helpers::NumberHelper

    def initialize(filesize)
      @filesize = filesize
    end

    def filesize
      @filesize.kind_of?(Fixnum) or raise FilesizeNotFixnum
      @filesize
    end

    def to_human_size
      number_to_human_size(filesize)
    end

    def self.to_human_size(filesize)
      new(filesize).to_human_size
    end
  end

  FilesizeNotFixnum = Class.new(StandardError)
end
