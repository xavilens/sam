class Knowledge < ActiveRecord::Base
  ################### RELACIONES ###################
  has_many :musician_knowledges
  has_many :musicians, through: :musician_knowledges

  # CAMPOS: nombre
end
