class RevertPolymorphicInSocialNetwork < ActiveRecord::Migration
  def change
    remove_column :social_networks, :socialeable_id
    remove_column :social_networks, :socialeable_type
  end
end
