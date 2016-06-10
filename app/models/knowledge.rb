class Knowledge < ActiveRecord::Base
  has_many :musician_knowledges
  has_many :musicians, through :musician_knowledges
end
