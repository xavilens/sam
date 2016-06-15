class ActivityType < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :nombre, presence: true
end
