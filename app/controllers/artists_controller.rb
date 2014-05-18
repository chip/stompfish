class ArtistsController < ApplicationController
  def index
    show_search_results(Artist)
  end

  def show
    @artist = Artist.find_by(id: params[:id])
    render_response(@artist, "200", not_found, "404") do
      @artist
    end
  end
end
