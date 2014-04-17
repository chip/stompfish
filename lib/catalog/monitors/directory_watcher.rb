require 'listen'

module Catalog
  module Monitors
    class DirectoryWatcher
      attr_reader :directory

      def initialize(directory)
        @directory = directory
      end

      def listen(&block)
       listener = Listen.to(directory) do |modified, added|
          yield added if block_given?
        end
       listener.start
      end 

      def self.listen(directory, &block)
        new(directory).listen(&block)
      end
    end
  end
end
