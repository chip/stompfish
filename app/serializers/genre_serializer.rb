class GenreSerializer < ActiveModel::Serializer
  cached
  delegate :cache_key, to: :object

  attributes :name
end
