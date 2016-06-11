class Musician < ActiveRecord::Base
  ################### VALIDACIONES ###################

  ################### RELACIONES ###################
  has_one :user, as: :profileable

  # TODO: Soft-delete?? Historial de grupos??
  has_many :members, dependent: :delete_all
  has_many :bands, through: :members
  has_many :musician_knowledges, dependent: :delete_all
  has_many :knowledges, through: :musician_knowledges

  # TODO: Campo Estado = {buscando grupo, ninguno}

  ################### METODOS ###################
  def knowledges
    self.musician_knowledges
  end
end
