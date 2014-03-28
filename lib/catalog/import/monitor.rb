require 'rb-inotify'

module Catalog
  module Import
    class Monitor
      def initialize(directory, ignore: nil)
        @directory = directory
        INotify::Notifier::RECURSIVE_BLACKLIST << ignore if ignore
      end

      def directory
        Dir.exists?(@directory) or raise DirectoryNotFound
        @directory
      end

      def listen(&block)
        notifier.watch(directory, :create, :recursive, :close_write) do |event|
          block.call(directory_for_event(event.absolute_name))
        end
        notifier.run
      end 

      private
      def notifier
        @not ||= INotify::Notifier.new
      end

      def directory_for_event(name)
        File.directory?(name) ? name : File.dirname(name)
      end
    end

    DirectoryNotFound = Class.new(StandardError)
  end
end
