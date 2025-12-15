require 'jwt'

class SessionsController < ApplicationController
  key = Rails.application.secret_key_base

  def create 
    username = params[:user][:username]
    password = params[:user][:password]

    user = User.find_by(username: username)

    puts "Class of user object: #{user.class}" if user
    puts "Method on user onject: #{user.methods.sort}" if user
    
    return render json: {error: "This user was not found "}, status: :unauthorized if user.nil?

    if user.authenticate(password)
      puts "DEBUG: user.id = #{user.id.inspect}"

      payload = { user_id: user.id, exp: 2.hours.from_now.to_i}
      token = JWT.encode(payload, KEY, "HS256")
      render json: { message: "Login was successful", user: user.as_json(only: [:id, :username, :email]), token: token}, status: :ok

    else
      render json: { error: "One or more inputs was incorrect, Please try again"}, status: :unauthorized
    end
  end
end
