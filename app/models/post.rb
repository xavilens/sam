class Post < ActiveRecord::Base
  ######## VALIDATIONS
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

  ######## RELATIONSHIPS
  belongs_to :user

  has_many :comments
  has_many :images, as: :imageable, dependent: :delete_all
  accepts_nested_attributes_for :images
  # has_one :image, as: :imageable, dependent: :delete
  # accepts_nested_attributes_for :image
end
