class SongSerializer < ActiveModel::Serializer
  # cache
  cached
  delegate :cache_key, to: :object

  # attributes
  attributes :id, :title, :track

  # associations
  has_one :artist, embed: :id
  has_one :album, embed: :id
  has_one :song_file
end
