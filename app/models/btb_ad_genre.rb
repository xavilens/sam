class BTBAdGenre < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :band_to_band_ad_id, presence: true
  validates :genre_id, presence: true

  ################### RELACIONES ###################
  belongs_to :band_to_band_ad
  belongs_to :genre
end
