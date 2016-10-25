class MainPost < ActiveRecord::Base
  ######## VALIDATIONS
  validates :post_id, presence: true

  ######## RELATIONSHIPS 
  belongs_to :post
end
