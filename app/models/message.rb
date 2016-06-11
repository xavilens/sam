class Message < ActiveRecord::Base
  
  ################### RELACIONES ###################
  belongs_to :conversation
  belongs_to :autor, class_name: 'User', foreign_key: 'user_id'
end
