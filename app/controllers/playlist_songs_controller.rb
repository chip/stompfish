class PlaylistSongsController < ApplicationController
  before_action { playlist_not_found(params[:playlist_id]) }

  def create
    pm = PlaylistManager.new(@playlist)
    render_response(@playlist, pm.errors) do
      pm.add(song: song, position: params[:position])
    end
  end

  def destroy
    pm = PlaylistManager.new(@playlist)
    render_response(@playlist, pm.errors, success: "200", failure: "404") do
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
