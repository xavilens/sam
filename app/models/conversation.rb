class Conversation < ActiveRecord::Base
  belongs_to :usuario_1, class_name: 'User', foreign_key: 'user_id'
  belongs_to :usuario_2, class_name: 'User', foreign_key: 'user_id'
end
