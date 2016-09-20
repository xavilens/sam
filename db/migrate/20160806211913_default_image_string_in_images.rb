class DefaultImageStringInImages < ActiveRecord::Migration
  def change
    change_column :images, :image, :string, default: ""
  end
end
