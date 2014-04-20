require 'catalog/importors/audio_file'
require 'catalog/monitors/directory_watcher'
require 'audio_file_utils/move_file'

module Catalog
  module Importors
    class AutoImport
      attr_reader :watch_dir, :import_dir

      def initialize watch_dir: MONITOR_SETTINGS["watch_dir"],
                     import_dir: MONITOR_SETTINGS["import_dir"]

        @watch_dir, @import_dir = watch_dir, import_dir
      end

      def start!
        Catalog::Monitors::DirectoryWatcher.listen(watch_dir) do |event|
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
        AudioFileUtils::MoveFile.new(source: file, base: import_dir)
      end

      def import_file(path)
        Catalog::Importors::AudioFile.add(path)
      end
    end
  end
end
