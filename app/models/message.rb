class Message < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :conversation_id, presence: true
  validates :autor, presence: true
  validates :cuerpo, presence: true

  ################### RELACIONES ###################
  belongs_to :conversation
  belongs_to :autor, class_name: 'User', foreign_key: 'user_id'
end
