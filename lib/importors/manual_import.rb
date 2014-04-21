require 'audio_file'
require 'find'

module Importors
  class ManualImport
    attr_reader :directory

    def initialize(directory)
      @directory = directory
    end

    def scan(&block)
      files.each do |file|
        audio_file = AudioFile.new(file)
        audio_file.add if audio_file.valid?
        yield if block_given?
      end
    end

    def self.scan(directory, &block)
      new(directory).scan(&block)
    end

    private
    def files
      Find.find(directory)
    end
  end
end
