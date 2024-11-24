class SleepRecord < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true
  validates :clock_out, presence: true, on: :update, if: :clock_out_changed?
  validate :clock_out_after_clock_in

  before_validation :assign_clock_in, on: :create
  before_validation :assign_duration, on: :update, if: :will_save_change_to_clock_out?

  private

  def assign_clock_in
    self.clock_in = Time.current
  end

  def clock_out_after_clock_in
    errors.add(:clock_out, "must be after clock_in") if clock_out && clock_out <= clock_in
  end

  def assign_duration
    self.duration = (clock_out - clock_in).to_i / 60 / 60 # in hours duration
  end

  def clock_out_changed?
    clock_out.present? && saved_change_to_clock_out?
  end
end
