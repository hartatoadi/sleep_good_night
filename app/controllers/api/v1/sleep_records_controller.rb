class Api::V1::SleepRecordsController < ApplicationController
  def following_sleep_records
    @following_sleep_records = current_user.followees
                                .joins(:sleep_records)
                                .where('sleep_records.created_at >= ?', 1.week.ago)
                                .order(duration: :desc)
  end
end
