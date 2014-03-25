class AlbumSerializer < ActiveModel::Serializer
  cached
  delegate :cache_key, to: :object

  attributes :id, :title
  has_one :artist
end
