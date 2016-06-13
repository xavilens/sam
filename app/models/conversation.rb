class Conversation < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :usuario_1, presence: true
  validates :usuario_2, presence: true
  # TODO: Cambiar a 'nombre'?
  validates :asunto, presence: true

  ################### RELACIONES ###################
  # TODO: Soft-delete??
  has_many :messages, dependent: :delete_all

  belongs_to :usuario_1, class_name: 'User', foreign_key: 'user_id'
  belongs_to :usuario_2, class_name: 'User', foreign_key: 'user_id'

end
