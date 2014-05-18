class Playlist < ActiveRecord::Base
  include Elasticsearch::Model

  # validations
  validates_presence_of :title
  validates :song_ids, only_integer_values: true

  def songs
    song_ids.map { |id| Song.find(id) }
  end
end
