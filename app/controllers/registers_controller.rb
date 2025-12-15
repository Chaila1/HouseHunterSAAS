class RegistersController < ApplicationController

  def create
    user = User.new(user_params)

    if user.save
      render json: { message: "Your user has been created", user: user.as_json(only: [:id, :username, :email :password])}, status: :created
    else
      render json: { errors: user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private 

  def user_paramsparams.require(:user).permit(:username, :email, :password)
  end
end
