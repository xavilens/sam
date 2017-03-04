class Instrument < ActiveRecord::Base
  ######## RELATIONSHIPS
  has_many :musician_knowledges
  has_many :musicians, through: :musician_knowledges

  has_many :member_instruments
  has_many :members, through: :member_instruments

end
