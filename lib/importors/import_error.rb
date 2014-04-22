module Importors
  class ImportError
    attr_reader :filename

    def initialize(filename: filename)
      @filename = filename
    end

    def capture(&block)
      begin
        yield if block_given?
      rescue Exception => error
        ImportLog.create!(stacktrace: "#{error}", filepath: filename)
      end
    end

    def self.capture(filename: filename, &block)
      new(filename: filename).capture(&block)
    end
  end
end
