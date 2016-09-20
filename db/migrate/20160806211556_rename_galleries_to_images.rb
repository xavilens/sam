class RenameGalleriesToImages < ActiveRecord::Migration
  def change
    rename_table :galleries, :images
    rename_column :images, :images, :image
    change_column :images, :image, :string, array: false
  end
end
