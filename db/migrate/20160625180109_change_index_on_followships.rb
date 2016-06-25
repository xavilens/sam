class ChangeIndexOnFollowships < ActiveRecord::Migration
  def change
    add_index :followships, :follower_id
    add_foreign_key :followships, :users, column: :follower_id

    rename_column :followships, :followed_id, :leader_id
    add_index :followships, :leader_id
    add_foreign_key :followships, :users, column: :leader_id
  end
end
