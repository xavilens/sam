class Message < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :conversation_id, presence: true
  validates :author_id, presence: true
  validates :body, presence: true

  ################### RELACIONES ###################
  belongs_to :conversation
  belongs_to :author_id, class_name: 'User', primary_key: 'id', foreign_key: 'author_id'
end
