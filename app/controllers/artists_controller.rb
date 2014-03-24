class ArtistsController < ApplicationController
  def index
    if params[:query]
      @artists = Artist.search(params[:query])
    else
      @artists = Artist.all
    end

    respond_to do |format|
      format.html
      format.json { render json: @artists }
    end
  end

  def show
    @artist = Artist.find(params[:id])
  end
end
