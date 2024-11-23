class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User', foreign_key: :follower_id
  belongs_to :followee, class_name: 'User', foreign_key: :followed_id

  validates :follower_id, uniqueness: { scope: :followed_id, message: "already follows this user" }
end
