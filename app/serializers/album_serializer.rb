class AlbumSerializer < ActiveModel::Serializer
  cached
  delegate :cache_key, to: :object

  attributes :id, :title
end
