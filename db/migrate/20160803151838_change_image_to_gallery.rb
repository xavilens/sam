class ChangeImageToGallery < ActiveRecord::Migration
  def change
    rename_table :images, :galleries
    rename_column :galleries, :image, :images
  end
end
