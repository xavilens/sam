class MusicianKnowledge < ActiveRecord::Base
  belongs_to :musician
  belongs_to :knowledge
end
