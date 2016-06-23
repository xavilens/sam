class Sala < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :n_reviews, presence: true
  validates :creator_id, presence: true

  ################### RELACIONES ###################
  belongs_to :creator_id, class_name: 'User', foreign_key: 'user_id'

  ################### METODOS ###################
  def calculate_rating(new_rate)
    return ( total_rating * n_reviews + new_rate ) / ( n_reviews + 1 )
  end
end
