class Genre < ActiveRecord::Base
  ######## SCOPES
  default_scope {order(:name)}
  
  ######## RELATIONSHIPS
  has_many :bands
end
