class AddCityToAd < ActiveRecord::Migration
  def change
    add_column :ads, :city, :string
    add_column :ads, :state, :string
    add_column :ads, :country, :string
  end
end
