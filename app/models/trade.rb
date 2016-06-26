class Trade < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :t_ad_type_id, presence: true
  validates :t_ad_item_id, presence: true

  ################### RELACIONES ###################
  belongs_to :t_ad_type
  belongs_to :t_ad_item

  has_one :ads, as: :adeable
end
