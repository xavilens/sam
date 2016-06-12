class DelegatedUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable

  ################### VALIDACIONES ###################
  # TODO: NotNull todos los campos!
  validates :delegated_user, presence: true
  validates :current_user, presence: true, uniqueness: {scope: :delegated_user}
  # TODO: Activo default = false
  validates :activo, presence: true

  ################### RELACIONES ###################
  belongs_to :delegated_user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :current_user, class_name: 'User', foreign_key: 'user_id'
end
