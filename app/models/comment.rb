class Comment < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :post_id, presence: true
  validates :user_id, presence: true

  ################### RELACIONES ###################
  belongs_to :post
  belongs_to :user
end
