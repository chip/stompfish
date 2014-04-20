require 'audio_file'
require 'find'

module Importors
  class Recursive
    attr_reader :directory

    def initialize(directory)
      @directory = directory
    end

    def scan(&block)
      files.each do |file|
        AudioFile.add(file)
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
