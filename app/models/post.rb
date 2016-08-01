class Post < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

  ################### RELACIONES ###################
  belongs_to :user
  
  has_many :comments
  has_many :images, as: :imageable
end
