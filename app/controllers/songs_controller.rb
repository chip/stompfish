class SongsController < ApplicationController
  def index
    if params[:query]
      @songs = Song.search(params[:query])
    else
      @songs = Song.all
    end

    respond_to do |format|
      format.html
      format.json { render json: @songs }
    end
  end

  def show
    @song = Song.find(params[:id])
  end
end
