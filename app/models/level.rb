class Level < ActiveRecord::Base
  ######## RELATIONSHIPS
  has_many :musician_knowledges
  has_many :instruments, through: :musician_knowledges
  has_many :musicians, through: :musician_knowledges
end
