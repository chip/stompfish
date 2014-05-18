class PlaylistSerializer < ActiveModel::Serializer
  # attributes
  attributes :id, :title, :songs

  def songs
    object.songs.map { |song| response_for_song(song) }
  end

  private
  def response_for_song(song)
    {id: song.id, url: url_for_song(song)}
  end

  def url_for_song(resource)
    url_for(host: ApplicationSettings["host_path"], controller: "songs", action: "show", id: resource)
  end
end
