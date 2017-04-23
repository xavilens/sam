class Event < ActiveRecord::Base
  ######## VALIDACIONES
  validates :name, presence: true
  validates :date, presence: true
  validates :event_type_id, presence: true
  validates :event_status_id, presence: true

  ######## SCOPES
  # Ordena por fecha de manera ascendente
  scope :asc, -> { order(date: :asc)}

  # Devuelve los 5 próximos eventos
  scope :next, -> (n){ asc.first(n) }

  # Devuelve los eventos de una ciudad
  scope :city, -> (city){ joins(:address).where(addresses: {city: city}).asc }

  # Devuelve los eventos de una comunidad autónoma
  scope :region, -> (region){ joins(:address).where("addresses.region like :region", region: "%#{region}%").asc }

  # Devuelve los eventos de un rango de fechas concreto
  scope :date, -> (start_date, finish_date){ where("date between :start_date and :finish_date",
    start_date: start_date, finish_date: finish_date).asc }

  ######## RELATIONSHIPS
  belongs_to :creator, class_name: 'User', primary_key: "id", foreign_key: "creator_id"
  belongs_to :event_status
  belongs_to :event_type

  has_many :event_participants
  accepts_nested_attributes_for :event_participants, allow_destroy: true, reject_if: :all_blank
  has_many :participants, through: :event_participants

  has_one :address, as: :addresseable
  accepts_nested_attributes_for :address, allow_destroy: true

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: proc { |att| att['title'].blank? || att['image'].blank? }

  has_many :conversation_relateds, as: :conversationable
  has_many :conversations, through: :conversation_relateds

  ######## METHODS

  # Devuelve el tipo del evento
  def type
    event_type.name
  end

  # Devuelve el estado del evento
  def status
    event_status.name
  end

  # Indica si hay participantes
  def participants?
    participants.any?
  end

  # Indica si hay imágenes
  def images?
    images.any?
  end

  # Devuelve la primera imagen
  def image
    images.first
  end

  # Devuelve el año en que se celebra el evento
  def year
    date.year
  end

  # Devuelve el mes en que se celebra el evento
  def month
    date.month
  end

  # Devuelve el día en que se celebra el evento
  def day
    date.day
  end
end
