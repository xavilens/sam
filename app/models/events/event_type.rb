class EventType < ActiveRecord::Base
  ######## SCOPES
  default_scope {order(:name)}
end
