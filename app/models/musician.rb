class Musician < ActiveRecord::Base
  has_one :user, as: :profileable
  has_many :musician_knowledges
  has_many :knowledges, through: :musician_knowledges

  # TODO: Campo Estado = {buscando grupo, ninguno}

  def knowledges
    self.musician_knowledges
  end
end
