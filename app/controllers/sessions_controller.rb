require 'jwt'

class SessionsController < ApplicationController
  KEY = Rails.application.secret_key_base

  def create
    username = params[:user][:username]
    password = params[:user][:password]
    user = User.find_by(username: username)
    return render json: { error: "User not found" }, status: :unauthorized if user.nil?

    if user.authenticate(password)
      payload = { user_id: user.id, exp: 2.hours.from_now.to_i }
      token = JWT.encode(payload, KEY, "HS256")
      render json: { message: "Login successful", user: user.as_json(only: [:id, :username, :email]), token: token }, status: :ok
    else
      render json: { error: "Incorrect credentials" }, status: :unauthorized
    end
  end
end

