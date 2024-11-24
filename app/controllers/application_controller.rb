class ApplicationController < ActionController::API
  attr_reader :current_user

  before_action :authenticate_user!

  private
  def authenticate_user!
    token = request.headers["Authorization"]
    unless token.present? && set_current_user(token)
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  # Set the current_user
  def set_current_user(token)
    @current_user = User.find_by(auth_token: token)
  end
end
