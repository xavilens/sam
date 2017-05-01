class ChangeFieldsFromSocialNetworksSet < ActiveRecord::Migration
  def change
    rename_column :social_networks_sets, :bandcamp, :bandcamp_url
    add_column :social_networks_sets, :vimeo_url, :string
  end
end
