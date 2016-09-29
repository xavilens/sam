class RemoveCategoryOfGenres < ActiveRecord::Migration
  def change
    remove_column :genres, :category, :string
  end
end
