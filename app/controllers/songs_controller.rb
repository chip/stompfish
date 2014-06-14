class SongsController < ApplicationController
  def index
    if params[:query]
      songs = SongSearch.search(params[:query])
    else
      songs = Song.all
    end
    render json: songs
  end

  def show
    render_find(Song)
  end
end
