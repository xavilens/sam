class RehearsalStudioUser < ActiveRecord::Base
  belongs_to :rehearsal_studio
  belongs_to :user
end
