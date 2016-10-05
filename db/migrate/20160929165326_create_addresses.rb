class CreateAddresses < ActiveRecord::Migration
  def change
    # create_table :addresses do |t|
    #   t.integer :addresseable_id
    #   t.string :addresseable_type
    #   t.string :street
    #   t.string :gstreet
    #   t.string :city
    #   t.string :state
    #   t.string :country
    #
    #   t.timestamps null: false
    # end
    add_column :addresses, :addresseable_type, :string
  end
end
