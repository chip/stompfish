class ApplicationController < ActionController::API
  helper_method :render_response
  helper_method :playlist_not_found

  def playlist_not_found(id)
    @playlist = Playlist.find_by(id: id)
    render json: {message: "Resource Not Found"}, status: "404" unless @playlist
  end

  def render_response(json, success, errors, failure, &block)
    if yield
      render json: json, status: success
    else
      render json: errors, status: failure
    end
  end
end
