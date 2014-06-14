class SongsController < ApplicationController
  def index
    render json: Song.all
  end

  def show
    render_find(Song)
  end
end
