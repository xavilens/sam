class CreateSocialNetworks < ActiveRecord::Migration
  def change
    create_table :social_networks do |t|
      t.string :facebook
      t.string :website
      t.string :gplus
      t.string :instagram
      t.string :bandcamp
      t.string :soundcloud
      t.string :twitter
      t.references :socialeable, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
