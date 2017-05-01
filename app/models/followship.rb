class Followship < ActiveRecord::Base
  ######## VALIDATIONS
  validates :leader, presence: true
  validates :follower, presence: true, uniqueness: {scope: :leader_id}

  ######## RELATIONSHIPS
  belongs_to :leader, class_name: "User", primary_key: 'id', foreign_key: "leader_id"
  belongs_to :follower, class_name: "User", primary_key: 'id', foreign_key:  "follower_id"

  ######## PAGINATION
  paginates_per 42
end
