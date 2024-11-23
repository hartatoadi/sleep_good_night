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

  def following_sleep_records
    sleep_records = current_user.followees.joins(:sleep_records)
                          .where('sleep_records.created_at >= ?', 1.week.ago)
                          .order('sleep_records.duration DESC')

    render json: SleepRecordSerializer.new(sleep_records)
  end

  private
  def set_user_target
    @user = User.find(params[:id])
  end
end
