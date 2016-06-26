class AddPrecisionToTrade < ActiveRecord::Migration
  def change
    change_column :trades, :price, :decimal, precision: 2
  end
end
