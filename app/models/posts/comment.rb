class Comment < ActiveRecord::Base
  ######## VALIDATIONS
  validates :post_id, presence: true
  validates :user_id, presence: true

  ######## RELATIONSHIPS 
  belongs_to :post
  belongs_to :user
end
