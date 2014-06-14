class AlbumsController < ApplicationController
  def index
    render json: Album.all
  end

  def show
    render_find(Album)
  end
end
