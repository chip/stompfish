class GenreSerializer < ActiveModel::Serializer
  # cache
  cached
  delegate :cache_key, to: :object

  # associations
  attributes :name
end
