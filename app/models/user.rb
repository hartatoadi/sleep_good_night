class User < ApplicationRecord
  has_many :sleep_records, dependent: :destroy
  has_many :follows, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy
  has_many :followees, through: :follows, source: :followee
  has_many :reverse_follows, class_name: 'Follow', foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :reverse_follows, source: :follower

  validates :name, presence: true, uniqueness: true
end
