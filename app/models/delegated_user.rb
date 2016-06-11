class DelegatedUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable

  belongs_to :delegated_user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :current_user, class_name: 'User', foreign_key: 'user_id'
end
