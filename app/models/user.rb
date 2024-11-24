class User < ApplicationRecord
  has_many :sleep_records, dependent: :destroy
  has_many :follows, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
  has_many :followees, through: :follows, source: :followee
  has_many :reverse_follows, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :reverse_follows, source: :follower

  validates :name, presence: true, uniqueness: true

  before_create :generate_auth_token

  def get_following_sleep_records
    followees
    .joins(:sleep_records)
    .where("sleep_records.created_at >= ?", 1.week.ago)
    .order(duration: :desc)
    .select("sleep_records.id, sleep_records.user_id, sleep_records.clock_in, sleep_records.clock_out, sleep_records.duration")
  end

  private

  def generate_auth_token
    self.auth_token = SecureRandom.hex(20)
  end
end
