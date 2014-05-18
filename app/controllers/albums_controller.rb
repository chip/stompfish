class AlbumsController < ApplicationController
  def index
    show_search_results(Album)
  end

  def show
    @album = Album.find_by(id: params[:id])
    render_response(@album, "200", not_found, "404") do
      @album
    end
  end
end
