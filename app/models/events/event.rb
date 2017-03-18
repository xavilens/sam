class Event < ActiveRecord::Base
  ######## VALIDACIONES
  validates :name, presence: true
  validates :date, presence: true
  # validates :time, presence: true
  # validates :street, presence: true
  # validates :city, presence: true
  # validates :state, presence: true
  # validates :country, presence: true
  # validates :max_participants, presence: true
  validates :event_type_id, presence: true
  validates :event_status_id, presence: true

  ######## SCOPES
  # Devuelve los 5 próximos eventos
  scope :next_five, -> { order(date: :asc).first(5) }

  ######## RELATIONSHIPS
  belongs_to :creator, class_name: 'User', primary_key: "id", foreign_key: "creator_id"
  belongs_to :event_status
  belongs_to :event_type

  has_many :event_participants
  accepts_nested_attributes_for :event_participants, allow_destroy: true, reject_if: :all_blank
  has_many :participants, through: :event_participants, class_name: "User", primary_key: "id", foreign_key: "user_id"

  # belongs_to :sala
  has_one :address, as: :addresseable
  accepts_nested_attributes_for :address, allow_destroy: true

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: proc { |att| att['title'].blank? || att['image'].blank? }

  ######## METHODS

  # Devuelve el tipo del evento
  def type
    event_type.name
  end

  # Devuelve el estado del evento
  def status
    event_status.name
  end

end
