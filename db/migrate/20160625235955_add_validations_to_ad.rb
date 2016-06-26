class AddValidationsToAd < ActiveRecord::Migration
  def change
    change_column :ads, :city, :string, null: false
    change_column :ads, :state, :string, null: false
    change_column :ads, :country, :string, null: false
  end
end
