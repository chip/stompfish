require 'fileutils'

module AudioFileUtils
  class Move
    attr_reader :base, :source

    def initialize(base: base, source: source)
      @base, @source = base, source
    end

    def relocate
      mkpath and move and new_path
    end

    def self.relocate(base: base, source: source)
      new(base: base, source: source).relocate
    end

    private
    def basename
      File.basename(filepath)
    end

    def destination
      @_destination ||= "#{base}/#{tags.artist}/#{tags.album}/"
    end

    def filepath
      @_filename ||= source.filepath
    end

    def mkpath
      FileUtils.mkdir_p(destination)
    end

    def move
      FileUtils.mv(filepath, destination)
    end

    def new_path
      @_new_path ||= "#{destination}#{basename}"
    end

    def tags
      @_tags ||= source.tags
    end
  end
end
