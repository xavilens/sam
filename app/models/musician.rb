class Musician < ActiveRecord::Base
  has_many :musician_knowledges
  has_many :knowledges, through: :musician_knowledges

  def knowledges
    self.musicianKnowledges
  end
end
