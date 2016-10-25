class TradeAd < ActiveRecord::Base
  ######## VALIDATIONS
  validates :t_ad_type_id, presence: true
  validates :t_ad_item_id, presence: true

  ######## RELATIONSHIPS
  has_one :ad, as: :adeable

  belongs_to :t_ad_type
  belongs_to :t_ad_item

end
