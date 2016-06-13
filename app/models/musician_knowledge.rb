class MusicianKnowledge < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :musician_id, presence: true
  validates :knowledge_id, presence: true, uniqueness: {scope: :musician_id}

  ################### RELACIONES ###################
  belongs_to :musician
  belongs_to :knowledge
end
