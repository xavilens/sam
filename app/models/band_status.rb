class BandStatus < ActiveRecord::Base
  ######## SCOPES
  default_scope {where("name <> 'Inactivo'")}
end
