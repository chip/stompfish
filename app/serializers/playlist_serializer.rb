class PlaylistSerializer < ActiveModel::Serializer
  # attributes
  attributes :id, :title, :songs

  # associations
  def songs
    object.playlist_collaborators.map { |pc| { id: pc.song_id, position: pc.position } }
  end
end
