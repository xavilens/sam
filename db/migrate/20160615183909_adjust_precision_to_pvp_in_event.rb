class AdjustPrecisionToPvpInEvent < ActiveRecord::Migration
  def change
    change_column :events, :pvp, :decimal, precision: 2
  end
end
