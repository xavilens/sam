class Conversation < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :user_1_id, presence: true
  validates :user_2_id, presence: true
  validates :subject, presence: true

  ################### RELACIONES ###################
  # TODO: Soft-delete??
  has_many :messages, dependent: :delete_all

  belongs_to :user_1_id, class_name: 'User', foreign_key: 'user_id'
  belongs_to :user_2_id, class_name: 'User', foreign_key: 'user_id'

end
