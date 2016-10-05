class CreateSocialNetworks < ActiveRecord::Migration
  def change
    create_table :social_networks do |t|
      t.integer :socialeable_id
      t.string :socialeable_type
      t.string :facebook
      t.string :website
      t.string :gplus
      t.string :instagram
      t.string :bandcamp
      t.string :soundcloud
      t.string :twitter

      t.timestamps null: false
    end
  end
end
