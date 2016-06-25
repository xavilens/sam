class RehearsalStudioReview < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :title, presence: true
  validates :rate, presence: true
  validates :user_id, presence: true
  validates :rehearsal_studio_id, presence: true, uniqueness: {scope: :user_id}

  ################### RELACIONES ###################
  belongs_to :user
  belongs_to :rehearsal_studio

  ################### METODOS ###################
end
