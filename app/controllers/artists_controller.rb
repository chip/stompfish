class ArtistsController < ApplicationController
  def index
    show_search_results(Artist)
  end

  def show
    render_find(Artist)
  end
end
