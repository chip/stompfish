class SongSerializer < ActiveModel::Serializer
  # cache
  cached
  delegate :cache_key, to: :object

  # attributes
  attributes :id, :title, :bit_rate, :duration, :filename, :filesize, :format, :mtime, :track

  # associations
  has_one :artist, embed: :id
  has_one :album, embed: :id
end
