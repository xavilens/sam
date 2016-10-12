class RenameSocialNetworkToSocialNetworSet < ActiveRecord::Migration
  def change
    rename_table :social_networks, :social_network_sets
  end
end
