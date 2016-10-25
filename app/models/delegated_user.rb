class DelegatedUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable

  ######## VALIDATIONS
  validates :delegated_user, presence: true
  validates :current_user, presence: true, uniqueness: {scope: :delegated_user}
  validates :active, presence: true

  ######## RELATIONSHIPS 
  belongs_to :current_user, class_name: 'User', primary_key: 'id', foreign_key: 'current_user_id'
  belongs_to :delegated_user, class_name: 'User', primary_key: 'id', foreign_key: 'delegated_user_id'
end
