class PlaylistSongsController < ApplicationController
  before_action { playlist_not_found(params[:playlist_id]) }

  def create
    pm = PlaylistManager.new(@playlist)
    render_response(@playlist, "201", pm.errors, "422") do
      pm.add(song: song, position: params[:position])
    end
  end

  def destroy
    pm = PlaylistManager.new(@playlist)
    render_response(@playlist, "200", pm.errors, "404") do
      pm.delete(song: song)
    end
  end

  private
  def playlist_params
    params.permit(:position)
  end

  def song
    Song.find_by(id: params[:id])
  end
end
