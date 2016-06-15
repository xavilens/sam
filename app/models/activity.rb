class Activity < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :user_id, presence: true
  validates :activity_type_id, presence: true
  validates :descripcion, presence: true

  ################### RELACIONES ###################
  belongs_to :user
  belongs_to :activity_type
end
