class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :addresseable, index: true, foreign_key: true
      t.string :street
      t.string :gstreet
      t.string :city
      t.string :state
      t.string :country

      t.timestamps null: false
    end
  end
end
