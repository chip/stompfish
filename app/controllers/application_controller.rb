class ApplicationController < ActionController::API
  def playlist_not_found(id)
    @playlist = Playlist.find_by(id: id)
    render json: not_found, status: "404" unless @playlist
  end

  def render_find(model)
    record = model.find_by(id: params[:id])
    handle_response(result: record, action: true)
  end

  def render_response(result, errors, success: "201", failure: "422", &block)
    action = yield
    handle_response(action: action, result: result, success: success, failure: failure, errors: errors)
  end

  private
  def handle_response(action: action, result: result, success: "200", failure: "404", errors: not_found)
    if action and result
      render json: result, status: success
    else
      render json: errors, status: failure
    end
  end

  def not_found
    {message: "Resource Not Found."}
  end
end
