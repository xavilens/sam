class ConversationRelated < ActiveRecord::Base
  ######## VALIDATIONS
  validates :conversation, presence: true
  validates :conversationable, presence: true

  ######## RELATIONSHIPS
  belongs_to :conversation
  belongs_to :conversationable, polymorphic: true
end
