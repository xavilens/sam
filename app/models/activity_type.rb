class ActivityType < ActiveRecord::Base
  ######## VALIDATIONS 
  validates :name, presence: true
end
