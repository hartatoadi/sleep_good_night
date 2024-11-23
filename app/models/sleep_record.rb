class SleepRecord < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true
  validates :clock_out, presence: true
  validate :clock_out_after_clock_in

  before_save :calculate_duration

  private

  def clock_out_after_clock_in
    errors.add(:clock_out, "must be after clock_in") if clock_out <= clock_in
  end

  def calculate_duration
    if clock_in && clock_out
      self.duration = (clock_out - clock_in).to_i # in second duration
    else
      self.duration = 0
    end
  end
end
