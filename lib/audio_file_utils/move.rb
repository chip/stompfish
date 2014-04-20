require 'fileutils'
require 'audio_file_utils/metadata'

module AudioFileUtils
  class Move
    attr_reader :source, :base

    def initialize(source: source, base: base)
      @source, @base, = source, base
    end

    def relocate
      return false unless tags[:artist] && tags[:album]
      mkpath and move
    end

    def destination
      @dest ||= "#{base}/#{tags[:artist]}/#{tags[:album]}/"
    end

    def new_path
      "#{destination}#{basename}"
    end

    def mkpath
      FileUtils.mkdir_p(destination)
    end

    def move
      FileUtils.mv(source, destination)
    end

    private
    def basename
      File.basename(source)
    end

    def tags
      @read ||= AudioFileUtils::Metadata.tags(source)
    end
  end
end
