class Genre < ActiveRecord::Base
  # CAMPOS: nombre, categoria
  has_many :bands
  has_many :bm_ad_genres
  has_many :band_musician_ad, through: :bm_ad_genres

  has_many :btb_ad_genres
  has_many :band_to_band_ad

  has_many :sala_genres
  has_many :salas, through: :sala_genres
end
