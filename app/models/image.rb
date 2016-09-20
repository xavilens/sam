class Image < ActiveRecord::Base

  ################### VALIDACIONES ###################

  # validates_processing_of :image
  # validates :images, presence: true


  ################### RELACIONES ###################

  belongs_to :imageable, polymorphic: true

  mount_uploader :image, ImageUploader

end
