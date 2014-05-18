class ApplicationController < ActionController::API
  helper_method :render_response
  helper_method :playlist_not_found
  helper_method :show_search_results

  def playlist_not_found(id)
    @playlist = Playlist.find_by(id: id)
    render json: not_found, status: "404" unless @playlist
  end

  def show_search_results(model)
    if params[:query]
      results = model.search(params[:query])
    else
      results = model.all
    end
    render json: results
  end

  def render_response(json, success, errors, failure, &block)
    if yield
      render json: json, status: success
    else
      render json: errors, status: failure
    end
  end

  def not_found
    {message: "Resource Not Found."}
  end
end
