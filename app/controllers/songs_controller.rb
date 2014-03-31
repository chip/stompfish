class SongsController < ApplicationController
  def index
    if params[:query]
      @songs = Song.search(params[:query])
    else
      @songs = Song.all
    end

    render json: @songs
  end

  def show
    @song = Song.find(params[:id])
  end
end
