class Message < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :conversation_id, presence: true
  validates :author_id, presence: true
  validates :body, presence: true

  ################### RELACIONES ###################
  belongs_to :conversation
  belongs_to :author_id, class_name: 'User', foreign_key: 'user_id'
end
