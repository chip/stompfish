module CatalogRecord
  class ArtistRecord
    attr_reader :name, :artist_model

    def initialize(name: name, artist_model: Artist)
      @name = name
      @artist_model = artist_model
    end

    def add
      artist_model.find_or_create_by(name: name)
    end

    def self.add(name: name, artist_model: Artist)
      new(name: name, artist_model: artist_model).add
    end
  end
end
