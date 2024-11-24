class Api::V1::SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create ]

  # just temporary for simple authentication, must change with other authentication like Devise, etc.
  def create
    user = User.find_by(name: params[:name])
    if user
      render json: { auth_token: user.auth_token }, status: :ok
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end
end
