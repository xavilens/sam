class Followship < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :leader, presence: true
  validates :follower, presence: true, uniqueness: {scope: :followed_id}

  ################### RELACIONES ###################
  belongs_to :leader, class_name: "User", foreign_key: "user_id"
  belongs_to :follower, class_name: "User", foreign_key: "user_id"
end
