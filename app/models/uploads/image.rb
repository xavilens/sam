class Image < ActiveRecord::Base
  ######## VALIDATIONS
  # validates_processing_of :image
  validates :image, presence: true
  validates :title, presence: true
  validates :imageable, presence: true

  ######## RELATIONSHIPS
  belongs_to :imageable, polymorphic: true

  ######## PAGINATION
  paginates_per 42

  ######## UPLOADER
  mount_uploader :image, ImageUploader
end
