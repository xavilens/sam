class MusicianKnowledge < ActiveRecord::Base
  ################### RELACIONES ###################
  belongs_to :musician
  belongs_to :knowledge
end
