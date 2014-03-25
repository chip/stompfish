class AlbumSerializer < ActiveModel::Serializer
  # cache
  cached
  delegate :cache_key, to: :object

  # attributes
  attributes :id, :title

  # associations
  has_one :genre
  has_one :release_date
end
