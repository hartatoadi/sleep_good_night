class Api::V1::SleepRecordsController < ApplicationController
  before_action :find_sleep_record, only: [ :update ]
  def create
    sleep_record = current_user.sleep_records.new
    if sleep_record.save
      render json: { message: "Clocked in successfully", sleep_record: sleep_record }, status: :created
    else
      render json: { errors: sleep_record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @sleep_record.update(clock_out: Time.current)
      render json: { message: "Clocked out successfully", sleep_record: @sleep_record }, status: :ok
    else
      render json: { errors: @sleep_record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def following_sleep_records
    @following_sleep_records = current_user.get_following_sleep_records
  end

  private
  def find_sleep_record
    @sleep_record = current_user.sleep_records.find(params[:id])
  end
end
