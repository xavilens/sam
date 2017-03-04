class RehearsalStudioUser < ActiveRecord::Base
  ######## RELATIONSHIPS
  belongs_to :rehearsal_studio
  belongs_to :user
end
