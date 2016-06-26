class BandToMember < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true

  ################### RELACIONES ###################
  has_one :ads, as: :adeable
  has_many :btm_ad_instruments
  has_many :instruments, through: :btm_ad_instruments

end
