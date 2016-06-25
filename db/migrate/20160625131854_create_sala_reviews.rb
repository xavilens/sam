class CreateSalaReviews < ActiveRecord::Migration
  def change
    create_table :sala_reviews do |t|
      t.string :title, null: false
      t.text :desciption
      t.boolean :rent_paid, default:false
      t.decimal :rent_price, precision: 5, scale: 2
      t.decimal :service_rate, precision: 5, scale: 1, null: false
      t.decimal :gear_rate, precision: 5, scale: 1, null: false
      t.decimal :total_rate, precision: 5, scale: 1, null: false
      t.decimal :money_earned, precision: 5, scale: 2
      t.references :user, index: true, foreign_key: true, null: false
      t.references :sala, index: true, foreign_key: true, null: false, unique: {scope: :user_id}

      t.timestamps null: false
    end
  end
end
