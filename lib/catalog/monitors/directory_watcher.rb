require 'rb-inotify'

module Catalog
  module Monitors
    class DirectoryWatcher
      attr_reader :directory

      def initialize(directory, ignore: nil)
        @directory = directory
        INotify::Notifier::RECURSIVE_BLACKLIST << ignore if ignore
      end

      def listen(&block)
        notifier.watch(directory, :create, :moved_to, :recursive) do |event|
          block.call(event.absolute_name)
        end

        Thread.new do
          notifier.run
        end
      end 

      def self.listen(directory, ignore: nil, &block)
        new(directory, ignore: ignore).listen(&block)
      end

      private
      def notifier
        @not ||= INotify::Notifier.new
      end
    end
  end
end
