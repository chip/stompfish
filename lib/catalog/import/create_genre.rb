module Catalog
  module Import
    class CreateGenre
      attr_reader :name, :genre_model

      def initialize(name: name, genre_model: Genre)
        @name = name
        @genre_model = genre_model
      end

      def add
        return unless name
        genre_model.find_or_create_by(name: name)
      end

      def self.add(name: name, genre_model: Genre)
        new(name: name, genre_model: genre_model).add
      end
    end
  end
end
