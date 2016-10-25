class Member < ActiveRecord::Base
  ######## VALIDATIONS
  validates :band_id, presence: true
  validates :musician_id, presence: true
  validates :instrument_id, presence: true, uniqueness: {scope: [:band_id, :musician_id]}

  ######## RELATIONSHIPS 
  belongs_to :band
  belongs_to :musician
  belongs_to :instrument
end
