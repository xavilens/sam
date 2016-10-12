class RenameColumnsInSocialNetworksSet < ActiveRecord::Migration
  def change
    rename_column :social_networks_sets, :facebook, :facebook_url
    rename_column :social_networks_sets, :twitter, :twitter_url
    rename_column :social_networks_sets, :youtube, :youtube_url
    rename_column :social_networks_sets, :soundcloud, :soundcloud_url
    rename_column :social_networks_sets, :website, :website_url
    rename_column :social_networks_sets, :instagram, :instagram_url
    rename_column :social_networks_sets, :gplus, :gplus_url
  end
end
