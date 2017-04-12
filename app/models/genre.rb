class Genre < ActiveRecord::Base
  ######## RELATIONSHIPS
  has_many :bands
end
