class CreateFollowships < ActiveRecord::Migration
  def change
    create_table :followships do |t|
      t.integer :followed_id, null: false
      t.integer :follower_id, null: false, unique: {scope: :followed_id}

      t.timestamps null: false
    end
  end
end
