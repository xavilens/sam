class SalaUser < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :sala_id, presence: true
  validates :user_id, presence: true

  ################### RELACIONES ###################
  belongs_to :sala
  belongs_to :user

  ################### METODOS ###################
end
