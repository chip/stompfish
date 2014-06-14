class SongSearch
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def search
    song_model.search do
      fulltext query
      paginate per_page: song_model.count
    end.results
  end

  def self.search(query)
    new(query).search
  end

  private
  def song_model
    Song
  end
end
