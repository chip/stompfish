class PlaylistSerializer < ActiveModel::Serializer
  # cache
  cached
  delegate :cache_key, to: :object

  # attributes
  attributes :id, :title, :songs

  # associations
  def songs
    object.playlist_collaborators.map { |pc| { id: pc.song_id, position: pc.position } }
  end
end
