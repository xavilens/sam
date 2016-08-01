class ChangeUrlColumnsInUser < ActiveRecord::Migration
  def change
    rename_column :users, :facebook_url, :facebook
    rename_column :users, :soundcloud_url, :soundcloud
    rename_column :users, :twitter_url, :twitter
    rename_column :users, :website_url, :website
    rename_column :users, :instagram_url, :instagram
    rename_column :users, :gplus_url, :gplus
    rename_column :users, :avatar_url, :avatar
    rename_column :users, :youtube_url, :youtube
  end
end
