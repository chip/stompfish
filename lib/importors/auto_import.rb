require 'audio_file'
require 'monitors/directory_monitor'

module Importors
  class AutoImport
    attr_reader :import_dir, :watch_dir

    def initialize(import_dir: import_dir, watch_dir: watch_dir)
      @import_dir, @watch_dir = import_dir, watch_dir
    end

    def start
      Monitors::DirectoryMonitor.listen(watch_dir) do |files|
        files.each do |file|
          audio_file = AudioFile.new(file)
          if audio_file.relocate(base: import_dir)
            AudioFile.new(audio_file.new_path).add
          end
        end
      end
    end

    def self.start(import_dir: import_dir, watch_dir: watch_dir)
      new(import_dir: import_dir, watch_dir: watch_dir).start
    end
  end
end
