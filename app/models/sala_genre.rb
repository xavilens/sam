class SalaGenre < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :sala_id, presence: true
  validates :genre_id, presence: true, uniqueness: {scope: :sala_id}

  ################### RELACIONES ###################
  belongs_to :sala
  belongs_to :genre

  ################### METODOS ###################
end
