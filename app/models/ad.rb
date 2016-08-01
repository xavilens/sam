class Ad < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :title, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :user_id, presence: true
  validates :adable_id, presence: true
  validates :adable_type, presence: true, uniqueness: {scope: :adable_id}

  ################### RELACIONES ###################
  belongs_to :user
  belongs_to :adeable, polymorphic: true

  has_many :images, as: :imageable
end
