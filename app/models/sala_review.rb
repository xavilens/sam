class SalaReview < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :title, presence: true
  validates :service_rate, presence: true
  validates :gear_rate, presence: true
  validates :user_id, presence: true
  validates :sala_id, presence: true, uniqueness: {scope: :user_id}

  ################### RELACIONES ###################
  belongs_to :user
  belongs_to :sala

  ################### METODOS ###################
end
