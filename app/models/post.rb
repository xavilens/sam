class Post < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :titulo, presence: true
  validates :cuerpo, presence: true
  validates :user_id, presence: true

  ################### RELACIONES ###################
  belongs_to :user
  has_many :comments
end
