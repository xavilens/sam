class CreateRehearsalStudios < ActiveRecord::Migration
  def change
    # create_table :rehearsal_studios do |t|
    #   t.string :name, null: false
    #   t.string :street, null: false
    #   t.string :city, null: false
    #   t.string :state, null: false
    #   t.string :country, null: false
    #   t.integer :rooms_avaliable
    #   t.integer :creator_id, null: false
    #   t.decimal :total_rate, precision: 2
    #
    #   t.timestamps null: false
    # end

    add_index :rehearsal_studios, :creator_id
    add_foreign_key :rehearsal_studios, :users, column: :creator_id
  end
end
