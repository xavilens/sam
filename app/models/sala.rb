class Sala < ActiveRecord::Base
  ######## VALIDATIONS
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :n_reviews, presence: true
  validates :creator_id, presence: true

  ######## RELATIONSHIPS 
  belongs_to :creator_id, class_name: 'User', primary_key: 'id', foreign_key: 'creator_id'

  has_many :sala_reviews
  has_many :sala_users
  has_many :users, through: :sala_users

  has_many :sala_genres
  has_many :genres, through: :sala_genres

  has_many :events

  ######## METHODS
  # Recalcula la valoración total de una sala al recibir una nueva calificación
  def calculate_rating(new_rate)
    ( total_rating * n_reviews + new_rate ) / ( n_reviews + 1 )
  end
end
