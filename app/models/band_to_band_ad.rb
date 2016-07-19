class BandToBandAd < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :type, presence: true
  validates :btb_ad_type_id, presence: true

  ################### RELACIONES ###################
  has_one :ad, as: :adeable
  belongs_to :btb_ad_type

  has_many :btb_ad_genres
  has_many :genres, through: :btb_ad_genres
end
