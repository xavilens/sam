class Musician < ActiveRecord::Base
  has_many :musician_knowledges
  has_many :knowledges, through: :musician_knowledges

  # TODO: Campo Estado = {}

  def knowledges
    self.musician_knowledges
  end
end
