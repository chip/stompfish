class PlaylistSongsController < ApplicationController
  before_action { playlist_not_found(params[:playlist_id]) }

  def create
    pm = PlaylistManager.new(@playlist)
    render_response(@playlist) do
      pm.add(song, position: params[:position])
    end
  end

  def destroy
    pm = PlaylistManager.new(@playlist)
    render_response(@playlist, success: "200", failure: "404") do
      pm.delete(song)
    end
  end

  def update
    pm = PlaylistManager.new(@playlist)
    render_response(@playlist) do
      pm.add(songs)
    end
  end

  private
  def playlist_params
    params.permit(:position)
  end

  def song
    Song.find(params[:id])
  end

  def songs
    params[:songs].map { |song| Song.find(song) }
  end
end
