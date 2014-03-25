class SongFileSerializer < ActiveModel::Serializer
  # cache
  cached
  delegate :cache_key, to: :object
 
  # attributes
  attributes :id, :bit_rate, :duration, :filename, :filesize, :format, :mtime
end
