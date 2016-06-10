class Member < ActiveRecord::Base
  belongs_to :band
  belongs_to :musician
  belongs_to :instrument, class_name: 'Knowledge'
end
