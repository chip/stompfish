require 'find'
require 'audio_file'
require 'importors/import_error'

module Importors
  class ManualImport
    attr_reader :directory

    def initialize(directory)
      @directory = directory
    end

    def scan(&block)
      files.each do |file|
        ImportError.capture(filename: file) do
          add_audio_file(file)
          yield if block_given?
        end
      end
    end

    def self.scan(directory, &block)
      new(directory).scan(&block)
    end

    private
    def files
      Find.find(directory)
    end

    def add_audio_file(file)
      audio_file = AudioFile.new(file)
      audio_file.add if audio_file.valid?
    end
  end
end
