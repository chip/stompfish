class ErrorsController < ActionController::API
  def routing
    render json: {message: "Resource Not Found."}
  end
end
