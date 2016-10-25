class Image < ActiveRecord::Base
  ######## VALIDATIONS
  # validates_processing_of :image
  # validates :images, presence: true

  ######## RELATIONSHIPS
  belongs_to :imageable, polymorphic: true

  mount_uploader :image, ImageUploader

end
