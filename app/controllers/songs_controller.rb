class SongsController < ApplicationController
  def index
    show_search_results(Song)
  end

  def show
    @song = Song.find_by(id: params[:id])
    render_response(@song, "200", not_found, "404") do
      @song
    end
  end
end
