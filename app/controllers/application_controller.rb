class ApplicationController < ActionController::API
  helper_method :render_response

  def render_response(json, success, errors, failure, &block)
    if yield
      render json: json, status: success
    else
      render json: errors, status: failure
    end
  end
end
