class User < ApplicationRecord
  has_many :sleep_records, dependent: :destroy
  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :follows, source: :followed
  has_many :followers, through: :follows, source: :follower
end
