class Member < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :band_id, presence: true
  validates :musician_id, presence: true
  # TODO: Migracion crea unicidad en la tupla!
  validates :instrument_id, presence: true, uniqueness: {scope: {:band_id, :musician_id}}

  ################### RELACIONES ###################
  belongs_to :band
  belongs_to :musician
  belongs_to :instrument, class_name: 'Knowledge'
end
