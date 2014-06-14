class ArtistsController < ApplicationController
  def index
    render json: Artist.all
  end

  def show
    render_find(Artist)
  end
end
