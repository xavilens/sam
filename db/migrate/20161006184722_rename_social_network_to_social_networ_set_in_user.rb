class RenameSocialNetworkToSocialNetworSetInUser < ActiveRecord::Migration
  def change
    # remove_foreign_key :users, column: :social_network_id
    # remove_index :users, :social_network_set_id
    # rename_column :users, :social_network_set_id, :social_networks_set_id
    # add_index :users, :social_networks_set_id

    rename_table :social_network_sets, :social_networks_sets

    add_foreign_key :users, :social_networks_sets
  end
end
