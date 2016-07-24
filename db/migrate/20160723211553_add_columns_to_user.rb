class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook_url, :string
    add_column :users, :twitter_url, :string
    add_column :users, :soundcloud_url, :string
    add_column :users, :website_url, :string
    add_column :users, :gplus_url, :string
    add_column :users, :instagram_url, :string
    add_column :users, :avatar_url, :string
  end
end
