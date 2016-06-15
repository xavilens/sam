class Followship < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :followed_id, presence: true
  validates :follower_id, presence: true, uniqueness: {scope: :followed_id}

  ################### RELACIONES ###################
  belongs_to :follower_id, class_name: "User", foreign_key: "user_id"
  belongs_to :followed_id, class_name: "User", foreign_key: "user_id"
end
