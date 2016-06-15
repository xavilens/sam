class MainPost < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :post_id, presence: true

  ################### RELACIONES ###################
  belongs_to :post
end
