class MusicianStatus < ActiveRecord::Base
  ######## SCOPES
  default_scope {order(:name)}

  ######## RELATIONS
  has_many :musicians
end
