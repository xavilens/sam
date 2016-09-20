class Ad < ActiveRecord::Base
  # VALIDACIONES
  validates :title, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :user_id, presence: true
  validates :adable_id, presence: true
  validates :adable_type, presence: true, uniqueness: {scope: :adable_id}

  # RELACIONES
  belongs_to :user
  belongs_to :adeable, polymorphic: true

  has_many :images, as: :imageable
  accepts_nested_attributes_for :images
  # has_one :image, as: :imageable, dependent: :delete
  # accepts_nested_attributes_for :image

end
