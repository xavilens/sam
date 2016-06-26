class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.references :t_ad_type, index: true, foreign_key: true, null: false
      t.references :t_ad_item, index: true, foreign_key: true, null: false
      t.decimal :price

      t.timestamps null: false
    end
  end
end
