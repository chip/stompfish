class AlbumsController < ApplicationController
  def index
    if params[:query]
      @albums = Album.search(params[:query])
    else
      @albums = Album.all
    end

    respond_to do |format|
      format.html
      format.json { render json: @albums }
    end
  end

  def show
    @album = Album.find(params[:id])
  end
end
