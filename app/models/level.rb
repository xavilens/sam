class Level < ActiveRecord::Base
  ######## SCOPES
  default_scope {order(:name)}
  
  ######## RELATIONSHIPS
  has_many :musician_knowledges
  has_many :instruments, through: :musician_knowledges
  has_many :musicians, through: :musician_knowledges
end
