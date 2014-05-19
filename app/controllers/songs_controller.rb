class SongsController < ApplicationController
  def index
    show_search_results(Song)
  end

  def show
    render_find(Song)
  end
end
