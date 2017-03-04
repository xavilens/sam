class BMAdGenre < ActiveRecord::Base
  ######## VALIDATIONS
  validates :band_musician_ad_id, presence: true
  validates :genre_id, presence: true, uniqueness: { scope: :band_musician_ad_id }

  ######## RELATIONSHIPS 
  belongs_to :band_musician_ad
  belongs_to :genre

end
