class ArtistsController < ApplicationController
  def index
    if params[:query]
      @artists = Artist.search(params[:query])
    else
      @artists = Artist.all
    end
    render json: @artists
  end

  def show
    @artist = Artist.find(params[:id])
  end
end
