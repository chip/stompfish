require 'audio_file'
require 'monitors/directory_monitor'
require 'audio_file_utils/move'

module Importors
  class AutoImport
    attr_reader :watch_dir, :import_dir

    def initialize watch_dir: MONITOR_SETTINGS["watch_dir"],
      import_dir: MONITOR_SETTINGS["import_dir"]

      @watch_dir, @import_dir = watch_dir, import_dir
    end

    def start!
      Monitors::DirectoryMonitor.listen(watch_dir) do |event|
        event.each do |file|
          mover = move_file(file)

          if mover.relocate
            import_file(mover.new_path)
          end
        end
      end
    end

    def self.start! watch_dir: MONITOR_SETTINGS["watch_dir"],
      import_dir: MONITOR_SETTINGS["import_dir"]

      new(watch_dir: watch_dir, import_dir: import_dir).start!
    end

    private
    def move_file(file)
      AudioFileUtils::Move.new(source: file, base: import_dir)
    end

    def import_file(path)
      AudioFile.add(path)
    end
  end
end