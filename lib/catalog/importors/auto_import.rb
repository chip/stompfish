module Catalog
  module Importors
    class AutoImport
      MONITOR_SETTINGS = YAML.load_file("#{Rails.root}/config/monitor_settings.yml")[Rails.env]

      attr_reader :watch_dir, :import_dir, :sleep_time

      def initialize watch_dir: MONITOR_SETTINGS["watch_dir"],
                     import_dir: MONITOR_SETTINGS["import_dir"],
                     sleep_time: 3

        @watch_dir, @import_dir, @sleep_time = watch_dir, import_dir, sleep_time
      end

      def start!
        Catalog::Monitors::DirectoryWatcher.listen(watch_dir) do |event|
          sleep sleep_time # Dirty hack to prevent race condition on import

          files_for_event(event).each do |file|
            mover = move_file(file)

            if mover.relocate
              import_file(mover.new_path)
            end
          end
        end
      end

      def self.start! watch_dir: MONITOR_SETTINGS["watch_dir"],
                      import_dir: MONITOR_SETTINGS["import_dir"],
                      sleep_time: 3

        new(watch_dir: watch_dir, import_dir: import_dir, sleep_time: sleep_time).start!
      end

      private
      def files_for_event(event)
        FilesystemTools::FindFiles.files(event)
      end

      def move_file(file)
        FilesystemTools::MoveFile.new(source: file, base: import_dir)
      end

      def import_file(path)
        Catalog::Importors::SingleFile.add(path)
      end
    end
  end
end
