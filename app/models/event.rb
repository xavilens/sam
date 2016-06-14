class Event < ActiveRecord::Base
  belongs_to :event_status
  belongs_to :event_type
  has_many :event_participants
  has_many :participants, through: :event_participants, class_name: "User", foreign_key: "user_id"
end
