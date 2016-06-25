class ActivityType < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :name, presence: true
end
