class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> {request.format.json? }

  def current_user
    @current_user
  end

  private

  def authenticate_user
    header = request.headers["Authorization"]
    token = header&.split(" ")&.last

    if token.present?
      begin
        decoded = JWT.decode(token, Rails.application.secret_key_base, true, { algorithm: "HS256" })
        @current_user = User.find(decoded[0]["user_id"])
      rescue JWT::DecodeError
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
    
