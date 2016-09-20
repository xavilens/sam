class ChangeColumnImagesInGallery < ActiveRecord::Migration
  def change
    change_column :galleries, :images, :string, array: true, default: []
  end
end
