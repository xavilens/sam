class UpdatingUserWithAddressAndSocialNetwork < ActiveRecord::Migration
  def change
    # add_column :social_networks, :youtube, :string
    # change_column :social_networks, :socialeable_id, :string, null:false
    # change_column :social_networks, :socialeable_type, :string, null:false
    # change_column :addresses, :addresseable_id, :string, null:false
    # change_column :addresses, :addresseable_type, :string, null:false
    #
    # remove_column :users, :city, :string
    # remove_column :users, :state, :string
    # remove_column :users, :country, :string
    # remove_column :users, :youtube, :string
    # remove_column :users, :gplus, :string
    # remove_column :users, :instagram, :string
    # remove_column :users, :website, :string
    # remove_column :users, :soundcloud, :string
    # remove_column :users, :twitter, :string
    # remove_column :users, :facebook, :string

    # rename_column :users, :addresses_id, :address_id
    # rename_column :users, :social_networks_id, :social_network_id
    #
    # add_index :users, :address_id
    # add_index :users, :social_network_id

    add_foreign_key :users, :addresses
    add_foreign_key :users, :social_networks
  end
end
