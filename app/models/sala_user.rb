class SalaUser < ActiveRecord::Base
  ######## VALIDATIONS 
  validates :sala_id, presence: true
  validates :user_id, presence: true

  ######## RELATIONSHIPS
  belongs_to :sala
  belongs_to :user
end
