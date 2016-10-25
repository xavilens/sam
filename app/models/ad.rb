class Ad < ActiveRecord::Base
  ######## VALIDATIONS
  validates :title, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :user_id, presence: true
  validates :adable_id, presence: true
  validates :adable_type, presence: true, uniqueness: {scope: :adable_id}

  ######## RELATIONSHIPS
  belongs_to :user
  belongs_to :adeable, polymorphic: true

  has_many :images, as: :imageable
  accepts_nested_attributes_for :images

end
