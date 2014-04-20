module CatalogRecord
  class ReleaseDateRecord
    attr_reader :year, :release_date_model

    def initialize(year: year, release_date_model: ReleaseDate)
      @year = year
      @release_date_model = release_date_model
    end

    def add
      return unless year
      release_date_model.find_or_create_by(year: year)
    end

    def self.add(year: year, release_date_model: ReleaseDate)
      new(year: year, release_date_model: release_date_model).add
    end
  end
end
