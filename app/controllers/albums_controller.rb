class AlbumsController < ApplicationController
  def index
    show_search_results(Album)
  end

  def show
    render_find(Album)
  end
end
