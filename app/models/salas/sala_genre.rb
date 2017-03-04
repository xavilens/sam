class SalaGenre < ActiveRecord::Base
  ######## VALIDATIONS 
  validates :sala_id, presence: true
  validates :genre_id, presence: true, uniqueness: {scope: :sala_id}

  ######## RELATIONSHIPS
  belongs_to :sala
  belongs_to :genre
end
