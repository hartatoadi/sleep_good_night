class Api::V1::UsersController < ApplicationController
  before_action :set_user_target, only: [:follow, :unfollow]
  def follow
    current_user.followees << @user
    render json: { message: "Now following #{@user.name}" }
  end

  def unfollow
    current_user.followees.delete(@user)
    render json: { message: "Unfollowed #{@user.name}" }
  end

  private
  def set_user_target
    @user = User.find(params[:id])
  end
end
