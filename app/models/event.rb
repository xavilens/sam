class Event < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :name, presence: true
  validates :date, presence: true
  # validates :time, presence: true
  # validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  # validates :max_participants, presence: true
  validates :event_type_id, presence: true
  validates :event_status_id, presence: true

  ################### RELACIONES ###################
  belongs_to :creator_id, class_name: 'User', primary_key: "id", foreign_key: "creator_id"

  belongs_to :event_status
  belongs_to :event_type

  has_many :event_participants
  has_many :participants, through: :event_participants, class_name: "User", primary_key: "id", foreign_key: "user_id"

  belongs_to :sala

  has_many :images, as: :imageable

  ################### METODOS ###################
end
