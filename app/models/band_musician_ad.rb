class BandMusicianAd < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :type, presence: true

  ################### RELACIONES ###################
  has_one :ads, as: :adeable
  has_many :bm_ad_genres
  has_many :genres, through: :bm_ad_genres
  has_many :bm_ad_instruments
  has_many :instruments, through: :bm_ad_instruments

end
