class PlaylistSerializer < ActiveModel::Serializer
  # attributes
  attributes :id, :title, :songs

  def songs
    object.songs.map { |song| url_for_resource(song) }
  end

  private
  def url_for_resource(resource)
    url_for(host: ApplicationSettings["host_path"], controller: "songs", action: "show", id: resource)
  end
end
