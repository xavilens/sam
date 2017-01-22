class MusicianKnowledge < ActiveRecord::Base
  ######## VALIDATIONS
  validates :musician_id, presence: true
  validates :instrument_id, presence: true, uniqueness: {scope: :musician_id}
  validates :level_id, presence: true

  ######## RELATIONSHIPS
  belongs_to :musician
  belongs_to :instrument
  belongs_to :level
end
