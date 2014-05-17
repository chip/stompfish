class PlaylistSerializer < ActiveModel::Serializer
  # attributes
  attributes :id, :title, :song_ids
end
