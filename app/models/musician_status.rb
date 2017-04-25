class MusicianStatus < ActiveRecord::Base
  ######## SCOPES
  default_scope {where("name <> 'Inactivo'")}
  
  ######## RELATIONS
  has_many :musicians
end
